
java_import java.awt.event.FocusListener

class FocusActionListener

    include FocusListener

    def initialize(on_focus=nil, focus_lost=nil, *args)

        @on_focus = on_focus
        @focus_lost = focus_lost
        @args = args
        super()

    end

    def focusGained( event )

        return if !@on_focus

        Thread.new {
          begin
              @on_focus.call( *@args )
          rescue => err
              alert_pop_err( err, "Focus Gained Error:" )
          end
        }
    end

    def focusLost(event)

        return if !@focus_lost

        Thread.new {
          begin
              @focus_lost.call( *@args )
          rescue => err
              alert_pop_err( err, "Focus Lost Error:" )
          end
        }
    end


end

