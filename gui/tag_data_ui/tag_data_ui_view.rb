class TagDataUiView < ApplicationView
  set_java_class 'gui.tag_data_ui.TagWindow'

  define_signal :name => :get_gui_handle, :handler => :get_gui_handle
  def get_gui_handle(model, transfer)
     return self.get_field_value( transfer[:gui_element] )
  end
end
