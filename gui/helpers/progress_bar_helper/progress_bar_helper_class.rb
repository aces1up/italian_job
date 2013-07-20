

class ProgressBarHelper

    include MonkeyBarsHelper

    def initialize( gui_element )
        @gui_element = gui_element
        @value       = 0
        @min         = nil
        @max         = nil

        init_gui_element
    end

    def init_gui_element()
        return if !@gui_element.is_a?( Symbol )
        @gui_element = get_gui_element_from_handle( @gui_element )
    end

    def init_progress_bar( min=nil, max=nil )
        @min = min ; @max = max
        @gui_element.set_minimum( @min ) if @min
        @gui_element.set_maximum( @max ) if @max
        @gui_element.set_string_painted( true )
    end

    def update_progress( msg=nil, value=nil )

        @value ||= value
        @value ||= 0
        @value += 1 

        @gui_element.set_string( msg ) if msg
        @gui_element.set_value( @value )

    end

    def set_indeterminate()
        @gui_element.setIndeterminate(true)
    end

end
