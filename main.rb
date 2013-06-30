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
  java.lang.System.exit(0)
end
GlobalErrorHandler.on_error {|exception, thread| show_error_dialog_and_exit(exception, thread) }

begin
  # Your application code goes here

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

  
  $working_directory = 'c:/lwb-trainer/'
  PhantomJSEXE = 'c:/temp/phantomjs.exe'

  #OUR HARDWARE CLASSES
  require 'hardware/process/process_helper'
  require 'hardware/enviornment/enviornment_variables'
  require 'hardware/browser/browser_helper'
  require 'thread/thread_each_pool'

  require 'botter'

  #utility
  require 'util/trainer_utility'


  #our trainer exceptions
  require 'exceptions/trainer_exceptions'

  #our gui Requires

  require 'gui/helpers/monkeybars/monkeybars_helpers'

  require 'gui/helpers/gui_generator/gui_item/value_converter'
  require 'gui/helpers/gui_generator/gui_item/gui_item_builder'
  require 'gui/helpers/gui_generator/gui_item/gui_item_class'

  require 'gui/helpers/gui_generator/gui_container/gui_container_class'
  require 'gui/helpers/action_listener_helper'
  require 'gui/helpers/dialog_helpers'
  require 'gui/helpers/combobox_helper'

  require 'gui/helpers/table_helpers/jtable_getvalue_helper'


  require 'gui/dashboard_ui/action_table/action_table_model'

  require 'gui/inspector_ui/inspector_ui_controller'
  require 'gui/action_data_ui/action_data_ui_controller'
  require 'gui/tag_data_ui/tag_data_ui_controller'
  require 'gui/dashboard_ui/dashboard_ui_controller'

  #our actual trainer test classes
  require 'trainer/actions/data/default_t_data'
  require 'trainer/actions/trainer_action'
  require 'trainer/actions/goto_t_action'

  require 'trainer/test_runner'



  class Tester

    include BotFrameWorkModules
    include MonkeyBarsHelper

     def initialize()
        @connection_class = EasyriderConnection
     end

     def test()
        init_vars
        get('http://www.weebly.com/')

        #ele = find(:input, :id, '-name')
        #puts ele.inspect
        #ele.element.element_info

     end

     def test_injector()
        #inject_monkeybar_methods
        ele = get_gui_element_handle( :inspector_menu_item )
        puts ele.obj_info
     end

     def handle()
        current_connection_handle
     end
  end


  #ActionDataUiController.instance.open
  #ActionDataUiController.instance.open
  DashboardUiController.instance.open
  #trainer_obj = GotoPageTrainer.new
  #data = trainer_obj.data
  #puts data.inspect

  #InspectorUiController.instance.open
  #InspectorUiController.instance.set_model_var( :conn, tester.handle )


rescue => e
  show_error_dialog_and_exit(e)
end