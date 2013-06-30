
#methods for actually creating these gui elements

module GUIItemBuilder
  
    def add_user_string()
        return if !@var_args.has_key?(:user_string)

        user_string_arr = @var_args[:user_string].is_a?(Array) ? @var_args[:user_string] : [ @var_args[:user_string] ]

        user_string_arr.each do |user_string|
            new_label = javax.swing.JLabel.new( user_string )
            new_label.setForeground( Color.black )
            new_label.set_visible(true)
            @element_panel.add( new_label )
        end
    end

    def set_element_panel_dimensions()

         if @auto_resize
              case @render_klass
                  when :textarea
                      @var_args[:pan_y] = @var_args[:ele_args].first * 30
              end
         end

         @element_panel.setPreferredSize( java.awt.Dimension.new( @var_args[:pan_x], @var_args[:pan_y] ) )
         @element_panel.setMaximumSize( java.awt.Dimension.new( @var_args[:pan_x], @var_args[:pan_y] ) )
    end

    def create_element_panel()
        @element_panel = javax.swing.JPanel.new
        #set the layout of the new panel here
        layout_klass = @var_args.has_key?(:layout) ? @var_args[:layout] : java.awt.FlowLayout
        @element_panel.setLayout( layout_klass.new() )

        #set the size of the new panel here
        set_element_panel_dimensions()

        #set the border here
        @element_panel.setBorder( javax.swing.BorderFactory.createLineBorder( Color.red ) )
        #puts "created element panel: #{@element_panel.obj_info}"
    end


    def add_gui_element()

        swing_class = render_class_to_swing( @render_klass )

        #puts "creating gui element using swing class: #{swing_class.inspect}"

        case swing_class.to_s

            when 'Java::JavaxSwing::JTextField'
                @var_args[:ele_args] ||= [20]
                @gui_element = javax.swing.JTextField.new( *@var_args[:ele_args] )

            when 'Java::JavaxSwing::JTextArea'

                @var_args[:ele_args] ||= [10, 25]
                @gui_element = javax.swing.JTextArea.new( *@var_args[:ele_args] )

                @var_args[:style] ||= :default
                #need to set word and line wrap here on new text area
                case @var_args[:style]

                    when :default
                        @enclose_in = javax.swing.JScrollPane.new( @gui_element )

                    when :wrap
                        @gui_element.setLineWrap( true )
                        @gui_element.setWrapStyleWord( true )

                end


            when 'Java::JavaxSwing::JSpinner'
                @var_args[:ele_args] ||= [1, 0, 20, 1]
                spin_model = javax.swing.SpinnerNumberModel.new( *@var_args[:ele_args] )
                spinner = javax.swing.JSpinner.new ; spinner.model = spin_model
                @gui_element = spinner

            when 'Java::JavaxSwing::JCheckBox'
                @gui_element = javax.swing.JCheckBox.new

            when 'Java::JavaxSwing::JButton'

                @var_args[:ele_args] ||= ['Default Button']
                @gui_element = javax.swing.JButton.new( *@var_args[:ele_args] )

                #set up the correct action listener here
                #if it was set manually
                if @value.nil?
                    @value = GenericActionListener.new( @var_args[:lam_block], true, *@var_args[:lam_args] )
                end

            when 'Java::JavaxSwing::JLabel'
                @var_args[:ele_args] ||= ""
                @gui_element = javax.swing.JLabel.new( *@var_args[:ele_args] )

            when 'Java::JavaxSwing::JComboBox'
                @var_args[:ele_args] ||= ['NotSet1', 'NotSet2']
                args = @var_args[:ele_args].map{|ele| ele.to_s} 
                @gui_element = javax.swing.JComboBox.new( args.to_java )
        end

    end

end
