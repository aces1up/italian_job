class ApplicationController < Monkeybars::Controller
  # Add content here that you want to be available to all the controllers
  # in your application

  def set_model_var( var, value )
      return false if !model.respond_to?("#{var.to_s}=")
      model.send("#{var.to_s}=", value)
  end

end