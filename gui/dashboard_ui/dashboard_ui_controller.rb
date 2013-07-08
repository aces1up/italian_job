class DashboardUiController < ApplicationController

  set_model 'DashboardUiModel'
  set_view 'DashboardUiView'
  set_close_action :exit

  def init_actions_combo()
      trainer_actions = TrainerAction.subclasses.map{ |klass| klass.to_s.gsub('Trainer','')  }
      model.action_list_combo = ComboBoxHelper.new( {:gui_element => :action_list_combo, :clear => true, :selected => 'GotoPage', :options => trainer_actions} )
  end

  def init_file_combo( gui_handle, directory, on_select_lam, selected=nil )
      files = dir_files( directory, true ).map{ |file| file.gsub( directory, '' ) }
      files.unshift( 'none' )
      selected ||= 'none'
      ComboBoxHelper.new( {:gui_element => gui_handle, :clear => true, :clear_listeners => true, :selected => selected, :options => files, :on_select_lambda => on_select_lam} )
  end

  def init_profile_combo( selected=nil )
      profile_combo_box = init_file_combo( :profile_combo, ProfileDirectory, model.on_profile_combo_select_lambda, selected )
      model.profile_list_combo = profile_combo_box
  end

  def init_test_files_combo( selected=nil )
      file_combo_box = init_file_combo( :test_file_combo, TestsDirectory, model.on_file_combo_select_lambda, selected )
      model.file_list_combo = file_combo_box
  end

  def init_version() ; signal( :do_version ) end

  def init_actions_table_listener()
      signal( :init_action_jtable_listener )
  end

  def load()

      InspectorUiController.instance.reboot
      InfoUiController.instance.close
      ActionDataUiController.instance.close
      TagDataUiController.instance.close

      model.test_runner             = TestRunner.new
      model.action_table_model      = ActionTableHandler.new

      #init our combo boxes
      init_actions_combo()          #<---- our action lists
      init_profile_combo()          #<---- our profile combo
      init_test_files_combo()       #<---- show our test files

      load_once()
  end

  def load_once()
      return if @loaded
      init_version()
      init_actions_table_listener()
      @loaded = true
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

  def show_info_window_menu_item_action_performed()
      InfoUiController.instance.open
  end

  def reboot_menu_item_action_performed()
      reboot()
  end

  def get_action_klass_selected()
      get_constant( "#{model.action_list_combo.get_selected}Trainer" )
  end

  def add_action_button_action_performed()
      model.test_runner.add( get_action_klass_selected )
  end

  def insert_action_button_action_performed()
      model.test_runner.insert( get_action_klass_selected )
  end

  def delete_action_button_action_performed()
      model.test_runner.delete()
  end

  def run_test_button_action_performed()
      model.test_runner.start_test
  end

  def save_test_menu_item_action_performed()
      FileChooserHelper.new( model.test_runner.save_to_disk, TestsDirectory, true )
  end

  def show_log( text )
      transfer[ :text ] = text
      signal( :show_log )
  end

end
