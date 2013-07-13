

class VerifyEmailTrainer < TrainerAction

    def self.trainer_data()

        data = {
                  :subject      =>
                  {
                      :value           => '',
                      :nil_value       => '',
                      :root_pan        => :action_data_panel,
                      :user_string     => "Enter Subject of Email: ",
                      :render_klass    => :string,
                  },

                  :email_type =>
                  {
                      :root_pan        => :action_data_panel,
                      :user_string     => "Select Email Type: ",
                      :render_klass    => :symbolselect,
                      :ele_args        => [ :catchall, :public ],
                      :value           => :catchall
                  },

                  :email_retry   =>
                  {
                      :root_pan        => :action_data_panel,
                      :user_string     => "Enter Max Email Retry: ",
                      :render_klass    => :integer,
                      #initial value, min, max, step
                      :ele_args        => [ 1, 1, 15, 1 ],
                      :value           => 3
                  },

                  :interval   =>
                  {
                      :root_pan        => :action_data_panel,
                      :user_string     => "Interval in Seconds Between Retries: ",
                      :render_klass    => :integer,
                      #initial value, min, max, step
                      :ele_args        => [ 1, 1, 60, 1 ],
                      :value           => 15
                  }

               }

        super( data )

    end
end

