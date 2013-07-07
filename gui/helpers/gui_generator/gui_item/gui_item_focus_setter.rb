

module GUIFocusSetter

    def default_focus_gained()
        lambda {
                @focused = true
                @gui_element.setBackground( FocusedBackgroundColor )
               }
    end

    def default_focus_lost()
        lambda {
                @focused = false
                @gui_element.setBackground( Color::WHITE )
               }
    end

    def set_default_focus_listener()
        default_focus_listener = FocusActionListener.new( default_focus_gained, default_focus_lost )
        @gui_element.addFocusListener( default_focus_listener )
    end

    def set_custom_focus_listener()
        listener = FocusActionListener.new( @var_args[ :focus_gained ], @var_args[ :focus_lost ], @var_args[:var_name] )
        @gui_element.addFocusListener( listener )
    end

    def set_focus_listener()
        set_default_focus_listener()
        set_custom_focus_listener()
    end

end
