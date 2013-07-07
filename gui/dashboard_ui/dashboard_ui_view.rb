class DashboardUiView < ApplicationView
  set_java_class 'gui.dashboard_ui.Dash'

  define_signal :name => :get_gui_handle, :handler => :get_gui_handle
  def get_gui_handle(model, transfer)
     return self.get_field_value( transfer[:gui_element] )
  end

  define_signal :name => :do_version, :handler => :do_version
  def do_version( model, transfer )
      version_label.set_text( "Version : #{Version}" )
  end

  define_signal :name => :init_action_jtable_listener, :handler => :init_action_jtable_listener
  def init_action_jtable_listener( model, transfer )
      actions_table.addMouseListener( ActionJtableMouseListener.new )
  end

  define_signal :name => :show_log, :handler => :show_log
  def show_log( model, transfer )
      log_textarea.set_text( transfer[:text] )
      log_textarea.setCaretPosition(0)
      dashboard_tabbed_pane.setSelectedIndex( 1 )
  end


end
