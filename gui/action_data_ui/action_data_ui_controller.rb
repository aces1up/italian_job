class ActionDataUiController < ApplicationController
  set_model 'ActionDataUiModel'
  set_view 'ActionDataUiView'
  set_close_action :close

  def test_create_button_action_performed()

      puts "testing"

      args =
      {
        :test_var =>
          {
            :value           => 'whats up?',
            :root_pan        => :action_data_panel,
            :user_string     => "My Test String...",
            :render_klass    => :symbol,
          },
        
        :dude_var => 
          {
            :root_pan        => :action_data_panel,
            :user_string     => "My Test String...",
            :render_klass    => :symbolselect,
            :ele_args        => [ :one, :two, :three ]
          }
      }



      #@item = GUIItem.new( args )
      $container = GUIContainer.new( args )
      $container.render
      
  end


end
