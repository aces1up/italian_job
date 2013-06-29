class DashboardUiController < ApplicationController
  set_model 'DashboardUiModel'
  set_view 'DashboardUiView'
  set_close_action :exit


  def inspector_menu_item_action_performed()
      InspectorUiController.instance.open
  end

end
