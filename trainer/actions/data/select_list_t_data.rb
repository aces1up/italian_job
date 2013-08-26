

class SelectListTrainer < TrainerAction

    extend ElementTrainerData

    def self.trainer_data()

        data = {

                  :select_value        =>
                  {
                      :value           => "",
                      :nil_value       => "",
                      :root_pan        => :action_data_panel,
                      :user_string     => "Select Value, Leave Empty to Select Random Option: ",
                      :render_klass    => :string,
                      :pan_y           => 50
                  },

                  :ignore_elements    =>
                  {
                      :value           => "",
                      :nil_value       => "",
                      :root_pan        => :action_data_panel,
                      :user_string     => "Ignore Elements Seperated by commas: ",
                      :render_klass    => :string,
                      :pan_y           => 50
                  }
        }

        super( data )
    end

end
