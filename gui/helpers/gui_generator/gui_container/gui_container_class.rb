

class GUIContainer

    include MonkeyBarsHelper

    attr_reader :focused

    def initialize( gui_elements={}, root_panel=nil, init_data={} )

        @gui_elements = gui_elements
        @root_panel   = root_panel
        @focused      = nil     #<--- current var_name that has focus

        init_handlers( init_data )

    end

    def clear_focused()
        @focused = nil
    end

    def has_focused?()
        #reports if an element in the @gui_elements has been focused or not.
        !@focused.nil?
    end
    
    def focus_gained()
        lambda { |var_name| @focused = var_name }
    end
    
    def focus_lost()
        lambda { |var_name| }
    end

    def init_handlers( init_data )

        @gui_elements.each do |var, var_args|

            #setup our initial_value if we have init_data
            var_args[:value] = init_data[var] if init_data.has_key?(var)

            var_args[:var_name]        = var
            var_args[:focus_gained]    = focus_gained
            var_args[:focus_lost]      = focus_lost
            var_args[:root_pan]        ||= @root_panel
            var_args[:gui_handler]     = GUIItem.new( var_args )
        end

    end

    def import( data={} )
        data.each do |import_var, value|
            if @gui_elements.has_key?( import_var )
                #@gui_elements[import_var][:value] = value
                @gui_elements[import_var][:gui_handler].set_value( value )
            end
        end
    end

    def get_root_panel()
        @gui_elements.first.last[:gui_handler].get_root_panel
    end
    
    def add( element_args )
        @gui_elements.merge!( element_args )
        init_handlers
    end

    def has_gui_handle?( var )
        #returns true if we have an gui_handler for the var
        #asked for.
        !@gui_elements[var][:gui_handler].nil?
    end

    def get_handler( var )
        @gui_elements[var][:gui_handler]
    end

    def get_focused_handler()
        get_handler( @focused )
    end

    def clear_root_pan()
        root_pan = get_root_panel
        root_pan.removeAll()
        root_pan.updateUI()
    end

    def render()

        clear_root_pan()

        @gui_elements.each do |var, var_args|
            next if !var_args[:gui_handler]
            var_args[:gui_handler].render
        end
    end

    def [](var)

        return nil if !@gui_elements[var]

        if ( handle_obj = get_handler( var ) )
            handle_obj.get_value
        else
            @gui_elements[var][:value]
        end

    end

    def save()
        @gui_elements.each do |var, var_args|
            handle_obj = get_handler( var )
            var_args[:value] = handle_obj.get_value
        end
    end

    def all_vars()
        vars = {}
        @gui_elements.each do |var_name, var_args|
            vars[ var_name ] = var_args[:value]
        end
        vars
    end

end
