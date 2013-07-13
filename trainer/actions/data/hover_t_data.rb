

class HoverElementTrainer < TrainerAction

    def self.trainer_data()

        data = {
                  :hover_mode =>
                  {
                      :root_pan        => :action_data_panel,
                      :user_string     => "Select Hover Method: ",
                      :render_klass    => :symbolselect,
                      :ele_args        => [ :javascript, :native ],
                      :value           => :javascript
                  },
        }

        super( data )
    end

    extend ElementTrainerData
end