

class SaveEmailVariableTrainer < TrainerAction

    extend SaveVarData

    def self.trainer_data()

        data = {
                  :search_string =>
                  {
                      :value           => '',
                      :root_pan        => :action_data_panel,
                      :user_string     => "Enter REXEX to Find in Confirmation Email: ",
                      :render_klass    => :string,
                      :pan_y           => 50
                  }
        }

        super( data )
    end

end
