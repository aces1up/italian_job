class ApplicationController < Monkeybars::Controller
  # Add content here that you want to be available to all the controllers
  # in your application

  def set_model_var( var, value )
      return false if !model.respond_to?("#{var.to_s}=")
      model.send("#{var.to_s}=", value)
  end

  def get_model_var(var)
      return false if !model.respond_to?("#{var.to_s}")
      model.send("#{var.to_s}")
  end

  def get_gui_handle(gui_element)
      transfer[:gui_element] = gui_element
      signal( :get_gui_handle )
  end

end