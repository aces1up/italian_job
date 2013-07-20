class SplashUiView < ApplicationView
  set_java_class 'gui.splash_ui.Splash'

  define_signal :name => :get_gui_handle, :handler => :get_gui_handle
  def get_gui_handle(model, transfer)
     return self.get_field_value( transfer[:gui_element] )
  end
end
