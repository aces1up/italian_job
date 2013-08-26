

class ClickElementTrainer < TrainerAction

        extend ElementTrainerData

        def self.trainer_data()
        data = {
                  :sleep_timer   =>
                  {
                      :root_pan        => :action_data_panel,
                      :user_string     => "Sleep After Click in Seconds: ",
                      :render_klass    => :integer,
                      #initial value, min, max, step
                      :ele_args        => [ 0, 0, 60, 1 ],
                      :value           => 0,
                      :nil_value       => 0

                  }
        }
        super( data )
        end

end
