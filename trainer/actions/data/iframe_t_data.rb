

class IframeActionTrainer < TrainerAction

    extend ElementTrainerData

    def self.trainer_data()

        data = {

                  :iframe_method    =>
                  {
                      :value           => "",
                      :nil_value       => "",
                      :root_pan        => :action_data_panel,
                      :user_string     => "Enter Dom Method to find Iframe SubElement: ",
                      :render_klass    => :symbol,
                      :pan_y           => 50
                  },

                  :iframe_how    =>
                  {
                      :value           => "",
                      :nil_value       => "",
                      :root_pan        => :action_data_panel,
                      :user_string     => "Enter Attribute to find Iframe SubElement: ",
                      :render_klass    => :symbol,
                      :pan_y           => 50
                  },

                  :iframe_what    =>
                  {
                      :value           => "",
                      :nil_value       => "",
                      :root_pan        => :action_data_panel,
                      :user_string     => "Enter What to Search for to find Iframe SubElement: ",
                      :render_klass    => :string,
                      :pan_y           => 50
                  },

                  :iframe_match_type =>
                  {
                      :root_pan        => :action_data_panel,
                      :user_string     => "Select Iframe SubElement Match Type: ",
                      :render_klass    => :symbolselect,
                      :ele_args        => [ :exact, :broad ],
                      :value           => :broad
                  },

                  :manipulation_mode =>
                  {
                      :root_pan        => :action_data_panel,
                      :user_string     => "Select Action to Perform on Iframe Element: ",
                      :render_klass    => :symbolselect,
                      :ele_args        => [ :set_element, :click, :hover_js, :hover ],
                      :value           => :set_element
                  },

                  :set_value =>
                  {
                      :value           => '',
                      :root_pan        => :action_data_panel,
                      :user_string     => "Enter Value to Set on Iframe Element: ",
                      :render_klass    => :string,
                      :pan_y           => 50
                  },
                  
                  :show_html =>
                  {
                      :root_pan        => :action_data_panel,
                      :user_string     => "Show Iframe HTML in Log for Debugging? ",
                      :render_klass    => :trueclass,
                      :value           => false
                  }


        }

        super( data )
    end

end
