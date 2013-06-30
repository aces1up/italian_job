

class GUIContainer

    include MonkeyBarsHelper

    def initialize( gui_elements={}, root_panel=nil )

        @gui_elements = gui_elements
        @root_panel   = root_panel

        init_handlers
        init_root_panel
    end

    def init_root_panel()
        @root_panel = get_gui_element_from_handle( @root_panel ) if @root_panel.is_a?( Symbol )
    end

    def init_handlers()
        @gui_elements.each do |var, var_args|
            var_args[:gui_handler] = GUIItem.new( var_args )
            @root_panel ||= var_args[:gui_handler].root_pan
        end
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

    def clear_root_pan()
        @root_panel.removeAll()
        @root_panel.updateUI()
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

        if ( handle_obj = get_handler( var ) and handle_obj.has_rendered )
            handle_obj.get_value
        else
            @gui_elements[var][:value]
        end

    end

end
