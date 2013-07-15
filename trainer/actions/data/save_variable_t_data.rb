
class SaveVariableTrainer < TrainerAction

    extend SaveVarData

    def self.trainer_data()

        data = {
                  :save_val =>
                  {
                      :value           => '',
                      :root_pan        => :action_data_panel,
                      :user_string     => "Enter Value to Save to Variable: ",
                      :render_klass    => :string,
                      :pan_y           => 50
                  }
        }

        super( data )
    end

end
