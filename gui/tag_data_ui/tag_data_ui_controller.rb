

class TagDataUiController < ApplicationController

  set_model 'TagDataUiModel'
  set_view 'TagDataUiView'
  set_close_action :close
    
  def on_tag_selected()
      lambda{ |selected| render_tag_options }
  end

  def init_actions_combo()
      ComboBoxHelper.new( { :gui_element        => :tag_list_combo, 
                            :clear              => true, 
                            :options            => TagList,
                            :on_select_lambda   => on_tag_selected
                          } )
  end

  def load()
      init_actions_combo()
      render_tag_options()
  end

  def action_data_container()
      #gets the current selected action_trainer_obj
      #GUI Data Container
      test_runner_obj.selected_obj.data
  end

  def focused_var()
      action_data_container.focused
  end
  
  def set_tag_selected()
      model.tag_selected = get_gui_handle( :tag_list_combo ).getSelectedItem.to_sym
  end

  def render_tag_options()
      set_tag_selected()
      model.render_tag_data
  end

  def insert_tag_button_action_performed()
      if focused_var
          model.append_tag
          model.export_tag_data()
      else
          alert_pop("Cannot Insert Tag, no Action Data Field Selected!")
      end
  end

end
