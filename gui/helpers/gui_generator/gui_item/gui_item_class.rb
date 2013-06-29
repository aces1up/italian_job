

class GUIItem

    DefaultPanelSize = {:pan_x => 375, :pan_y => 40}

    GetSetMap =
    {
        Java::JavaxSwing::JTextField => {:set_method => :set_text, :set_converter => :to_gui_from_string, :get_method => :get_text, :get_converter => :from_gui_to_string},
        Java::JavaxSwing::JLabel     => {:set_method => :set_text, :set_converter => :to_gui_from_string, :get_method => nil },
        Java::JavaxSwing::JSpinner   => {:set_method => :set_value, :get_method => :get_value },
        Java::JavaxSwing::JCheckBox  => {:set_method => :setSelected, :get_method => :isSelected },
        Java::JavaxSwing::JButton    => {:set_method => :addActionListener},
        Java::JavaxSwing::JTextArea  => {:set_method => :set_text, :set_converter => :value_to_gui_textbox, :get_method => :get_text, :get_converter => :from_gui_to_array},
        Java::JavaxSwing::JComboBox  => {:set_method => :setSelectedItem, :set_converter => :to_gui_from_string, :get_method => :getSelectedItem, :get_converter => :from_gui_to_string}
    }


    include MonkeyBarsHelper
    include GUIItemBuilder
    include ValueConveter


    attr_accessor :value
    attr_reader   :has_rendered

    def initialize ( var_args={} )

        @var_args         = var_args
        @root_pan         = var_args[:root_pan]     ||   nil
        @render_klass     = var_args[:render_klass] ||   nil   #<---  will be :textarea, :button, :spinner, etc..etc..
        @auto_resize      = var_args[:auto_resize]  ||   true
        @value            = var_args[:value]        ||   nil   #<---  the vaue retrieved from the gui_element

        @swing_klass      = nil                               #<---  the swing klass of gui_element
        @element_panel    = nil                               #<---  this is the panel that enclosed our gui_element
        @gui_element      = nil                               #<---  gui element we created with this class
        @enclose_in       = nil                               #<---  if we are enclosing @gui_element in an additional panel

        #state Variables
        @has_rendered     = false                             #<--- set to true after we have rendered at least once.
        @is_generated     = false                             #<--- set to true when we have used this object to build this element


        @var_args[:pan_x] = @var_args[:pan_x] || DefaultPanelSize[:pan_x]
        @var_args[:pan_y] = @var_args[:pan_y] || DefaultPanelSize[:pan_y]


        #structure of var_args

        #  :root_pan         root panel that the panel this gui element is enclosed in
        #  :v_klass          variable klass : :string, :integer, :array, etc
        #  :gui_handle_name  manually set a already created gui element, the variable of the gui_element.

        #  :nil_value     if value == to this value then we will set @value = nil
        #                 if this is of type Java swing component we
        #                 use it directly to render the gui component
        #  :user_string   string to show along within the panel to user

        #  :pan_x         panel width enclosing this element
        #  :pan_y         panel height enclosing this element

        #  :layout        Java Swing Flow Layout class we want to layout
                          #this gui element in sub panel

        #  :load_lam      # Just a Lambda to ensure is called before we render the
                          # Gui Element, can be used to setup custom code to
                          # Perform actions on a Gui Element before rendering
						  # passed the gui element created to the load_lam as only
						  # paramater

        #  :listener      # a listener we attach to the gui element
                          # after creating it

        #  :listener_type # if listener is specified, this is the listener type we instantiate


        #  :gui_args      # this is an array of args to be passed when
                          # creating the gui_elemement

        raise GUIError, "Cannot Built Gui Item for #{@render_klass.inspect} -- No Root Panel Specified!" if !@gui_element.is_a?( Symbol ) and !@root_pan

        init_element()
    end

    def render_class_to_swing( render_klass )
        #converts our render klass ex :textfield, :textarea to :
        #   textfield => Java::JavaxSwing::JTextField
        #   textarea  => Java::JavaxSwing::JCheckBox
        case render_klass.to_sym
           when :string         ; javax.swing.JTextField
           when :integer        ; javax.swing.JSpinner
           when :trueclass      ; javax.swing.JCheckBox
           when :symbol         ; javax.swing.JTextField
           when :button         ; javax.swing.JButton
           when :textarea       ; javax.swing.JTextArea
           when :tag            ; javax.swing.JTextField
           when :symbolselect   ; javax.swing.JComboBox
        else
            raise GUIError, "Cannot Determine Swing class type from Render Klass : #{render_klass.inspect}"
        end
    end

    def swing_element_to_render_klass( element )
        case element.class.to_s
            when /JTextField/   ;   :string
            when /JLabel/       ;   :string
            when /JSpinner/     ;   :integer
            when /JCheckBox/    ;   :trueclass
            when /JButton/      ;   :button
            when /JTextArea/    ;   :textarea
            when /JComboBox/    ;   :symbolselect
        else
            raise GUIError, "Cannot Determine Render Klass type from Swing Class : #{element.class.to_s}"
        end
    end

    def init_root_panel()
        return if !@root_pan.is_a?( Symbol )
        puts "getting root panel: #{@root_pan.inspect}"
        found = get_gui_element_from_handle( @root_pan )
        raise GUIError, "Unable to Get Root Panel Swing Element for : #{@root_pan.inspect}" if !found
        @root_pan = found
    end

    def init_gui_element_with_handle()
        found = get_gui_element_from_handle( @gui_element )
        raise GUIError, "Unable to Get Gui Element Handle for : #{@gui_element.inspect}" if !found
        @gui_element    = found
        @render_klass   = swing_element_to_render_klass( @gui_element ) 
    end
    
    def build_gui_element()
      
        @is_generated = true

        init_root_panel()
   
        add_gui_element()
        create_element_panel()   #<--- create the element panel this gui_element is enclosed in
        add_user_string()

        #add_gui_listener()

        #actually add the element we created to the appropriate panel here
        # check to see if this gui_element is enclosed in another element.
        # enclose in right now is used for the textarea scroll panels
        @enclose_in ? @element_panel.add( @enclose_in ) : @element_panel.add( @gui_element )
                        
    end

    def create_gui_element()
        #1.  Check to see if the @gui_element is symbol if so retreive the handle
        @gui_element.is_a?( Symbol ) ? init_gui_element_with_handle : build_gui_element
    end

    def init_element()
        create_gui_element()
    end
    
    
    #our info and rendering methods

    def has_nil_value?( val )
        return false if !@var_args[ :nil_value ]
        val == @var_args[:nil_value]
    end
    
    def get_value()
        #gets the value from our gui element
        #set @value with it and returns @value

        swing_klass    = render_class_to_swing( @render_klass )
        get_method     = GetSetMap[ swing_klass ][ :get_method ]
        convert_method = GetSetMap[ swing_klass ][ :get_converter ]
        return if !get_method

        #1.  Get the new value
        #2.  Check if new value is nil value
        #    if it is, set @value to nil
        #3.  run converter if there is one found

        val = @gui_element.send( get_method )
        if has_nil_value?( val )
            @value = nil
        else
            @value = val
            #run converter here if there is one.
            send( convert_method ) if convert_method
        end

        @value
    end
    
    def set_value( val=nil)
        #set the value from @value onto our Gui Element
        #of value is not nil we change @value to the new value
        @value = val if !val.nil?
        return if @value.nil?

        swing_klass = render_class_to_swing( @render_klass )
        set_method  = GetSetMap[ swing_klass ][ :set_method ]
        convert_method = GetSetMap[ swing_klass ][ :set_converter ]

        return if !set_method

        send( convert_method ) if convert_method

        puts "sending set value to element: #{@gui_element.obj_info} --  #{@value.inspect}"
        @gui_element.send( set_method, @value )
    end
    
    def render_gui_panel()
        puts "rending GUI Panel Now -- [ Root Panel: #{@root_pan.obj_info} ] -- [ Element Panel: #{@element_panel.obj_info} ]"
        @root_pan.add( @element_panel )
        @root_pan.revalidate
    end

    def render()
        #sets the current value stored on the gui element
        render_gui_panel if !@has_rendered
        set_value()
        @has_rendered = true
    end



end
