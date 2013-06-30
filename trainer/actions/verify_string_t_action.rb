
class VerifyStringTrainer < TrainerAction

    def self.trainer_data()

        data = {
                  :verify_string =>
                  {
                      :value           => '',
                      :root_pan        => :action_data_panel,
                      :user_string     => "Enter Search String to Find in HTML: ",
                      :render_klass    => :string,
                      :pan_y           => 50
                  },

                  :match_type =>
                  {
                      :root_pan        => :action_data_panel,
                      :user_string     => "Select Match Type: ",
                      :render_klass    => :symbolselect,
                      :ele_args        => [ :exact, :broad ],
                      :value           => :broad
                  }

               }

        super( data )

    end
end

