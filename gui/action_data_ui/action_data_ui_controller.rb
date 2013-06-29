class ActionDataUiController < ApplicationController
  set_model 'ActionDataUiModel'
  set_view 'ActionDataUiView'
  set_close_action :close

  def test_create_button_action_performed()

      puts "testing"

      args = {
          :root_pan        => :action_data_panel,
          :user_string     => "My Test String...",
          :render_klass    => :symbolselect,
          :ele_args        => [ :one, :two, :three ]
      }

      @item = GUIItem.new( args )
      
  end

  def test_render_button_action_performed()
      @item.render
      #@item.set_value( 4 )
  end

  def test_get_button_action_performed()
      val = @item.get_value
      puts "got val: #{val.inspect}"
  end

end
