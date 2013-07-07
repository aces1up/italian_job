

class GUIContainer

    include MonkeyBarsHelper

    def initialize( gui_elements={} )

        @gui_elements = gui_elements
        init_handlers

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

    def init_handlers()
        @gui_elements.each do |var, var_args|
            var_args[:gui_handler] = GUIItem.new( var_args )
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
