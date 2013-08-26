
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
                  },

                  :attach_proxy =>
                   {
                      :value           => false,
                      :root_pan        => :action_data_panel,
                      :user_string     => "Attach Proxy to Account? : ",
                      :render_klass    => :trueclass,
                      :pan_y           => 30
                  },

                  :is_variable  =>
                  {
                      :value           => false,
                      :root_pan        => :action_data_panel,
                      :user_string     => "Is Container Variable Direct? : ",
                      :render_klass    => :trueclass,
                      :pan_y           => 30
                  }
        }

        super( data )
    end

end
