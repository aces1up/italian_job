#===============================================================================
# Much of the platform specific code should be called before Swing is touched.
# The useScreenMenuBar is an example of this.
require 'rbconfig'
require 'java'

#===============================================================================
# Platform specific operations, feel free to remove or override any of these
# that don't work for your platform/application

case Config::CONFIG["host_os"]
when /darwin/i # OSX specific code
  java.lang.System.set_property("apple.laf.useScreenMenuBar", "true")
when /^win|mswin/i # Windows specific code
when /linux/i # Linux specific code
end

# End of platform specific code
#===============================================================================

  def init_output_format()

      if STOUT_To_File then
        #redirect standard output to file
        $stdout = File.new("#{$working_directory}stdout.txt", 'w+')
        $stderr = File.new("#{$working_directory}sterr.txt", 'w+')

        #$stdout = File.open( "NUL", 'w' )
        #$stderr = File.open( "NUL", 'w' )

      end
  end

  require 'fileutils'

  $working_directory = 'c:/lwb-trainer/'
  $display_gui       = true
  Version            = 'Italian Job 1.0.7'
  STOUT_To_File      = false

  FileUtils.mkdir( $working_directory ) if !File.directory?( $working_directory )
  init_output_format()


$LOAD_PATH << File.expand_path(File.dirname(__FILE__))
require 'manifest'

# Set up global error handling so that it is consistantly logged or outputed
# You will probably want to replace the puts with your application's logger
def show_error_dialog_and_exit(exception, thread=nil)
  puts "Error in application"
  puts "#{exception.class} - #{exception}"
  if exception.kind_of? Exception
    puts exception.backtrace.join("\n")
  else
    # Workaround for JRuby issue #2673, getStackTrace returning an empty array
    output_stream = java.io.ByteArrayOutputStream.new
    exception.printStackTrace(java.io.PrintStream.new(output_stream))
    puts output_stream.to_string
  end

  # Your error handling code goes here
  
  # Show error dialog informing the user that there was an error
  title = "Application Error"
  message = "The application has encountered an error and must shut down."
  
  javax.swing.JOptionPane.show_message_dialog(nil, message, title, javax.swing.JOptionPane::DEFAULT_OPTION)
  #java.lang.System.exit(0)
end
GlobalErrorHandler.on_error {|exception, thread| show_error_dialog_and_exit(exception, thread) }

begin
  # Your application code goes here


  #set look and feel here
  #java_import javax.swing.UIManager
  #javax.swing.UIManager.setLookAndFeel("javax.swing.plaf.nimbus.NimbusLookAndFeel");

  java_import javax.swing.tree.DefaultMutableTreeNode
  java_import javax.swing.JTree
  java_import javax.swing.tree.DefaultTreeModel
  java_import java.awt.event.MouseAdapter
  java_import java.awt.event.MouseEvent
  java_import javax.swing.SwingUtilities
  java_import javax.swing.JPopupMenu
  java_import javax.swing.JMenuItem
  java_import java.awt.event.ActionListener
  java_import java.awt.event.FocusListener
  java_import java.awt.Color
  java_import javax.swing.JFileChooser
  java_import javax.swing.filechooser.FileSystemView

  require 'thread/thread_each_pool'

  #utility
  require 'util/trainer_utility'

  #our gui Requires
  require 'gui/helpers/monkeybars/monkeybars_helpers'
  require 'gui/helpers/progress_bar_helper/progress_bar_helper_class'


  #our Splash Screen
  require 'gui/splash_ui/splash_ui_controller'
  require 'gui/splash_ui/splash_ui_model'
  require 'gui/splash_ui/splash_ui_view'

  $boot_log_handler = SplashUiController.instance
  SplashUiController.instance.open

  SplashUiController.instance.update_msg('Loading Bot FrameWork..')
  require 'botter'
  SplashUiController.instance.update_msg('Loading Constants...')
  require 'constants'

  #our trainer exceptions
  require 'exceptions/trainer_exceptions'

  #our Proxy Extensions
  require 'cache/proxy/proxy_cache_patches'


  SplashUiController.instance.update_msg('Loading GUI...')
  #Gui Generator Helper
  require 'gui/helpers/gui_generator/gui_item/value_converter'
  require 'gui/helpers/gui_generator/gui_item/gui_item_focus_setter'
  require 'gui/helpers/gui_generator/gui_item/gui_item_builder'
  require 'gui/helpers/gui_generator/gui_item/gui_item_class'
  require 'gui/helpers/gui_generator/gui_container/gui_container_class'

  #Our General GUI Helpers
  require 'gui/helpers/listeners/action_listener_helper'
  require 'gui/helpers/listeners/focus_listener'
  require 'gui/helpers/dialog_helpers'
  require 'gui/helpers/combobox_helper'
  require 'gui/helpers/filechooserhelper/file_chooser_helper'

  #jtable helpers
  require 'gui/helpers/table_helpers/jtable_getvalue_helper'

  #Our Proxy GUI TAble
  require 'gui/dashboard_ui/proxy_table/proxy_table_renderer'
  require 'gui/dashboard_ui/proxy_table/proxy_jtable_handler'

  
  #jtree_helpers
  require 'gui/helpers/jtree_helpers/jtree_render_hash_helper/jtree_hash_default_node'
  #menu Helpers
  require 'gui/helpers/menu_helper/menu_helper_class'


  require 'gui/dashboard_ui/action_table/action_table_renderer'
  require 'gui/dashboard_ui/action_table/action_table_listener'
  require 'gui/dashboard_ui/action_table/action_table_model'

  require 'gui/inspector_ui/inspector_ui_controller'
  require 'gui/inspector_ui/inspector_ui_model'
  require 'gui/inspector_ui/inspector_ui_view'


  require 'gui/action_data_ui/action_data_ui_controller'
  require 'gui/action_data_ui/action_data_ui_model'
  require 'gui/action_data_ui/action_data_ui_view'


  require 'gui/tag_data_ui/tag_data_ui_controller'
  require 'gui/tag_data_ui/tag_data_ui_model'
  require 'gui/tag_data_ui/tag_data_ui_view'


  require 'gui/tag_data_ui/tag_handlers/default_tag_handler'
  require 'gui/tag_data_ui/tag_handlers/captcha_tag_handler'
  require 'gui/tag_data_ui/tag_handlers/rand_file_line_tag_handler'



  require 'gui/dashboard_ui/dashboard_ui_controller'
  require 'gui/dashboard_ui/dashboard_ui_model'
  require 'gui/dashboard_ui/dashboard_ui_view'


  #our info_ui Requires
  require 'gui/info_ui/info_ui_controller'
  require 'gui/info_ui/info_ui_model'
  require 'gui/info_ui/info_ui_view'

  require 'gui/info_ui/var_jtree/var_jtree_container_node'
  require 'gui/info_ui/var_jtree/var_jtree_variable_node'
  require 'gui/info_ui/var_jtree/var_jtree_root_node'


  #our actual trainer test classes

  #data classes
  require 'trainer/actions/data/save_var_t_data'
  require 'trainer/actions/data/element_t_data'

  require 'trainer/actions/data/default_t_data'
  require 'trainer/actions/export_to_load_data'
  require 'trainer/actions/trainer_action_gui_helper'
  require 'trainer/actions/trainer_action'
  require 'trainer/actions/data/click_element_t_data'
  require 'trainer/actions/data/set_element_t_data'
  require 'trainer/actions/data/select_list_t_data'
  require 'trainer/actions/data/iframe_t_data'
  require 'trainer/actions/data/drag_and_drop_t_data'
  require 'trainer/actions/data/save_regex_t_action'
  require 'trainer/actions/data/save_email_var_t_data'
  require 'trainer/actions/data/save_variable_t_data'
  require 'trainer/actions/data/goto_t_action'
  require 'trainer/actions/data/hover_t_data'
  require 'trainer/actions/data/modify_variable_t_data'
  require 'trainer/actions/data/raw_post_t_data'
  require 'trainer/actions/data/verify_string_t_action'
  require 'trainer/actions/data/save_element_attribute_data'
  require 'trainer/actions/data/save_cookie-t_data'
  require 'trainer/actions/data/save_raw_post_variable_t_data'
  require 'trainer/actions/data/verify_email_t_data'
  require 'trainer/actions/data/verify_element_t_data'


  require 'trainer/connection_initializer'

  require 'trainer/load_save_module'
  require 'trainer/profile_initializer'
  require 'trainer/test_runner'

  SplashUiController.instance.close
  
  DashboardUiController.instance.open




rescue => e
  show_error_dialog_and_exit(e)
end