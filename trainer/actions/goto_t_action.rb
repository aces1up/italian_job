

class GotoPageTrainer < TrainerAction

    def self.trainer_data()

        data = {
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
    
        super( data )

    end
end
