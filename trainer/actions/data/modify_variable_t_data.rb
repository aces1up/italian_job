



class ModifyVariableTrainer < TrainerAction

    def self.trainer_data()

        data = {

                  :modify_variable     =>
                  {
                      :value           => "",
                      :nil_value       => "",
                      :root_pan        => :action_data_panel,
                      :user_string     => "Enter Variable to Modify: ",
                      :render_klass    => :symbol,
                      :pan_y           => 50
                  },

                  :search_for          =>
                  {
                      :value           => "",
                      :nil_value       => "",
                      :root_pan        => :action_data_panel,
                      :user_string     => "Regex to Match, leave empty to modify entire variable: ",
                      :render_klass    => :string,
                      :pan_y           => 50
                  },

                  :do_escape =>
                  {
                      :root_pan        => :action_data_panel,
                      :user_string     => "Escape Regex? ",
                      :render_klass    => :trueclass,
                      :value           => false
                  },

                  :remove_match =>
                  {
                      :root_pan        => :action_data_panel,
                      :user_string     => "Remove Match from String? ",
                      :render_klass    => :trueclass,
                      :value           => false
                  },

                  :replace_with        =>
                  {
                      :value           => "",
                      :nil_value       => "",
                      :root_pan        => :action_data_panel,
                      :user_string     => "Replace Match with, leave empty to delete Match: ",
                      :render_klass    => :string,
                      :pan_y           => 50
                  },

                  :conversion_mode =>
                  {
                      :root_pan        => :action_data_panel,
                      :user_string     => "Run Conversion on Match ( Optional ): ",
                      :render_klass    => :symbolselect,
                      :ele_args        => [ :none, :to_url, :url_decode ],
                      :value           => :none
                  },

                  :replace_mode =>
                  {
                      :root_pan        => :action_data_panel,
                      :user_string     => "Replace Mode: ",
                      :render_klass    => :symbolselect,
                      :ele_args        => [ :first_match, :all_matches ],
                      :value           => :first_match
                  }
        }

        super( data )
    end

end
