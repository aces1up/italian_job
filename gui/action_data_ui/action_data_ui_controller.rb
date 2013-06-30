class ActionDataUiController < ApplicationController
  set_model 'ActionDataUiModel'
  set_view 'ActionDataUiView'
  set_close_action :close

  def test_runner_obj()
      DashboardUiController.instance.get_model_var( :test_runner )
  end

  def save_trainer_data_button_action_performed()
      selected_action = test_runner_obj.selected_obj
      selected_action.save_trainer_data if selected_action
  end
end
