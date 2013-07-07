
module TrainerActionGUIHelper

    #gui handling stuff

    def update()
      DashboardUiController.instance.get_model_var( :action_table_model ).update
    end

    def update_msg( msg_output, log_level, thread )

      @output = msg_output
      @log   += "#{msg_output}\n"
      update()

    end

    def render_trainer_data()
      begin
          ActionDataUiController.instance.open
          ActionDataUiController.instance.set_action_label
          @data.clear_focused
          @data.render
      rescue => err
          alert_pop_err( err, "Render Data Error: " )
      end
    end

    def render_log()
        DashboardUiController.instance.show_log( @log )
    end

end

class ActionGUIDataHelper < GUIContainer
    #assists with handling tag args and data
    #from the tag options window

    def import_tag_data( var_name, data={} )
        # adds a :tag_data field to the var_args for specified var_name
        # format for :tag_data
        #   :tag => tag_args => {}
        return if !@gui_elements[var_name]
        puts "importing tag data for var_name: #{var_name.inspect} --> #{data.inspect}"
        @gui_elements[var_name][:tag_data] ||= {}
        @gui_elements[var_name][:tag_data].merge! data
    end

end
