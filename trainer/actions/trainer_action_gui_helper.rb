
module TrainerActionGUIHelper

    #gui handling stuff

    def update()
        DashboardUiController.instance.get_model_var( :action_table_model ).update
    end

    def update_msg( msg_output, log_level, thread )

      #receives log messages from our log handler
      #in the bot framework gem

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

    include ExportToLoadData

    #assists with handling tag args and data
    #from the tag options window

    def import_tag_data( var_name, data={} )
        # adds a :tag_data field to the var_args for specified var_name
        # format for :tag_data
        #   :tag => tag_args => {}
        return if !@gui_elements[var_name]
        @gui_elements[var_name][:tag_data] ||= {}
        @gui_elements[var_name][:tag_data].merge! data
    end

    def value_has_tags?( val )
        val =~ /~~(.+?)~~/
        !$1.nil?
    end

    def all_vars()

        vars = {}

        @gui_elements.each do |var_name, var_args|

            value = case

                when var_args[:value].nil? ; nil

                when ( var_args.has_key?( :tag_data ) and value_has_tags?( var_args[:value] ) )

                 {
                    :value     =>  var_args[:value],
                    :tag_data  =>  var_args[:tag_data]
                 }
                
            else
                 var_args[:value]
            end

            vars[ var_name ] = value

        end

        deep_copy ( vars )

    end
    
end
