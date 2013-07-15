

class GotoPageTrainer < TrainerAction

    def self.trainer_data()

        data = {
                  :url =>
                  {
                      :value           => '',
                      :nil_value       => '',
                      :root_pan        => :action_data_panel,
                      :user_string     => "Enter URL to Fetch: ",
                      :render_klass    => :string,
                  },

                  :clear_cookies =>
                  {
                      :root_pan        => :action_data_panel,
                      :user_string     => "Clear Cookies Before Fetch? ",
                      :render_klass    => :trueclass,
                      :value           => false
                  },

                  :use_images =>
                  {
                      :root_pan        => :action_data_panel,
                      :user_string     => "Load Images? ",
                      :render_klass    => :trueclass,
                      :value           => false
                  },

                  :user_agent =>
                  {
                      :root_pan        => :action_data_panel,
                      :user_string     => "Set Custom User Agent: ",
                      :render_klass    => :string,
                      :value           => false,
                      :nil_value       => ''
                  }
               }
    
        super( data )

    end
end
