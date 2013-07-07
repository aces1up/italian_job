

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
          @data.render
      rescue => err
          alert_pop_err( err, "Render Data Error: " )
      end
    end

    def render_log()
        DashboardUiController.instance.show_log( @log )
    end

end
