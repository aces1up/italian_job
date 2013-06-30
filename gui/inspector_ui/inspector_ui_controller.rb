
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

  def reboot()
      model.conn = nil
      close
  end

  def init_jtree()
      #re_initializes the Jtree with the connection handle
      #in the model
      transfer[:conn] = model.conn
      signal( :do_init_jtree )
  end

  def allowed?()
      if !model.conn
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
          model.conn.screenshot( filename )
          open_ie( "file:///#{filename}" )
      }
  end

end
