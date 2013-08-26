


class SaveCookieTrainer < TrainerAction

    extend SaveVarData

    def self.trainer_data()

        data = {
                  :cookie_name =>
                  {
                      :value           => '',
                      :root_pan        => :action_data_panel,
                      :user_string     => "Enter Cookie name to Save to Variable: ",
                      :render_klass    => :string,
                      :pan_y           => 50
                  }
        }

        super( data )
    end

end
