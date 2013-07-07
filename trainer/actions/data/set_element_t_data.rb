

class SetElementTrainer < TrainerAction

    def self.trainer_data()

        data = {
                  :set_value =>
                  {
                      :value           => '',
                      :root_pan        => :action_data_panel,
                      :user_string     => "Enter Value to Set on Element: ",
                      :render_klass    => :string,
                      :pan_y           => 50
                  }
        }

        super( data )
    end

    extend ElementTrainerData
end
