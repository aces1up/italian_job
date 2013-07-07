class ActionDataUiController < ApplicationController

  set_model 'ActionDataUiModel'
  set_view 'ActionDataUiView'
  set_close_action :close

  def load()
      set_action_label()
  end

  def close()
      test_runner_obj.selected_obj.data.clear_focused if test_runner_obj
      super()
  end

  def set_action_label()
      action_klass = test_runner_obj.selected_obj.action
      label        = get_gui_handle( :action_class_label )
      label.set_text( action_klass )
  end

  def open_inspector_button_action_performed()
      InspectorUiController.instance.open
  end

  def tag_options_button_action_performed()
      TagDataUiController.instance.open
  end

  def save_trainer_data_button_action_performed()
      selected_action = test_runner_obj.selected_obj
      selected_action.save_trainer_data if selected_action
      close
      TagDataUiController.instance.close
  end
end
