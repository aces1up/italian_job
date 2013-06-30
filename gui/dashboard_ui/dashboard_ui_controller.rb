class DashboardUiController < ApplicationController

  set_model 'DashboardUiModel'
  set_view 'DashboardUiView'
  set_close_action :exit

  def init_actions_combo()
      trainer_actions = TrainerAction.subclasses.map{ |klass| klass.to_s.gsub('Trainer','')  }
      model.action_list_combo = ComboBoxHelper.new( {:gui_element => :action_list_combo,:options => trainer_actions} )
  end

  def init_actions_table_listener()
      signal( :init_action_jtable_listener )
  end

  def load()
      model.test_runner             = TestRunner.new
      model.action_table_model      = ActionTableHandler.new
      init_actions_combo()
      init_actions_table_listener()
  end

  def teardown()
      model.action_table_model.clear_model if model.action_table_model
      model.test_runner = nil
  end

  def reboot()
      #hard reboot the trainer if something breaks big time.
      teardown()
      load()
  end

  def close()
      teardown()
      super()
  end

  def inspector_menu_item_action_performed()
      InspectorUiController.instance.open
  end

  def reboot_menu_item_action_performed()
      reboot()
  end

  def add_action_button_action_performed()
      action_klass = get_constant( "#{model.action_list_combo.get_selected}Trainer" )
      model.test_runner.add( action_klass )
  end

  def run_test_button_action_performed()
      model.test_runner.start_test
  end


end
