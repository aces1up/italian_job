class InfoUiController < ApplicationController
  set_model 'InfoUiModel'
  set_view 'InfoUiView'
  set_close_action :close

  def runner_obj()
      DashboardUiController.instance.get_model_var( :test_runner )
  end

  def trainer_vars()
      if runner_obj and runner_obj.test_thread and runner_obj.test_thread[:vars]
          runner_obj.test_thread[:vars]
      else
          nil
      end
  end

  def conn_vars()
      if runner_obj and runner_obj.test_thread and runner_obj.test_thread[:conns]
          runner_obj.test_thread[:conns]
      else
          nil
      end
  end
  
  def init_var_jtree()
      signal( :do_var_init_jtree )
  end

  def refresh_vars_button_action_performed
      trainer_vars ? init_var_jtree : alert_pop("Cannot Refresh -- No Trainer Vars Available...")
  end

  def refresh_conn_vars_button_action_performed()

      if conn_vars
          transfer[ :jtree_handle ]     = :conn_vars_jtree
          transfer[ :jtree_data ]       = conn_vars.main_connection.all_connection_info
          signal( :init_variable_jtree )
      else
          alert_pop("Cannot Refresh -- No Connection Vars Available...")
      end

  end

end
