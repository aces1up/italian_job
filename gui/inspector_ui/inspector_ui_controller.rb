
require 'gui/inspector_ui/jtree_handlers/inspector_listener'
require 'gui/inspector_ui/jtree_handlers/inspector_menu_handler'
require 'gui/inspector_ui/jtree_handlers/inspector_default_node'
require 'gui/inspector_ui/jtree_handlers/inspector_info_node'
require 'gui/inspector_ui/jtree_handlers/inspector_attribute_node'
require 'gui/inspector_ui/jtree_handlers/inspector_root_node'


class InspectorUiController < ApplicationController
  set_model 'InspectorUiModel'
  set_view 'InspectorUiView'
  set_close_action :close

  include BrowserWindow
  
  def init_filter_combo()
      filter_options = DOM_Elements.dup ; filter_options.unshift( 'none' )
      model.filter_combo = ComboBoxHelper.new( {:gui_element => :filter_combo_box, :clear => true, :selected => 'none', :options => filter_options} )
  end

  def filter_selected?()
      model.filter_combo.get_selected != 'none'
  end

  def filter_selected()
      model.filter_combo.get_selected
  end

  def test_runner_connection_handle()
      return nil if !test_runner_obj or !test_runner_obj.test_thread
      test_runner_obj.test_thread.connection_handle
  end

  def load()
      init_filter_combo()
  end

  def reboot()
      close
  end

  def init_jtree()
      #re_initializes the Jtree with the connection handle
      #in the model
      transfer[:conn] = test_runner_connection_handle
      signal( :do_init_jtree )
  end

  def allowed?()
      if ( !test_runner_connection_handle )
          alert_pop("No Connection Currently Initialized...")
          return false
      end
      true
  end

  def refresh_button_action_performed()

      return if !allowed?

      Thread.new {
        begin
            init_jtree
        rescue => err
            alert_pop_err( err, "Render Elements Error: " )
        end
      }
  end

  def show_screenshot_action_performed()

      return if !allowed?

      Thread.new {
          filename = "#{ScreenShotDirectory}screenshot-#{rand( 9999999 )}.png"
          test_runner_connection_handle.screenshot( filename )
          open_ie( "file:///#{filename}" )
      }
  end

end
