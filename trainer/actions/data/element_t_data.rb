
module ElementTrainerData

    def trainer_data( other_data={} )

        other_data.merge!( {

                  :method    =>
                  {
                      :value           => "",
                      :nil_value       => "",
                      :root_pan        => :action_data_panel,
                      :user_string     => "Enter Dom Method to find Element: ",
                      :render_klass    => :symbol,
                      :pan_y           => 50
                  },

                  :how    =>
                  {
                      :value           => "",
                      :nil_value       => "",
                      :root_pan        => :action_data_panel,
                      :user_string     => "Enter Attribute to find Element: ",
                      :render_klass    => :symbol,
                      :pan_y           => 50
                  },

                  :what    =>
                  {
                      :value           => "",
                      :nil_value       => "",
                      :root_pan        => :action_data_panel,
                      :user_string     => "Enter What to Search for to find Element: ",
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
        } )

        super( other_data )

    end
end
