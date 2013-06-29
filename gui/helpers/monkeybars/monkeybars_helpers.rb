
module MonkeyBarsHelper

    def get_gui_element_from_handle( var )

        ApplicationController.subclasses.each do |subclass|
           begin
               return subclass.instance.get_gui_handle(var)
           rescue => err
             next
           end
        end

        false

    end

end
