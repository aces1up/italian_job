class TagDataUiController < ApplicationController
  set_model 'TagDataUiModel'
  set_view 'TagDataUiView'
  set_close_action :close

  def load()
      puts "loading tag window..."
      var = test_runner_obj.selected_obj.data.focused
      puts "got focused: #{var.inspect}"
  end

end
