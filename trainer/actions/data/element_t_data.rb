
module ElementTrainerData

    def trainer_data( other_data={} )

        data = {

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
                  },

                  :use_xpath   =>
                  {
                      :value           => false,
                      :root_pan        => :action_data_panel,
                      :user_string     => "Use Xpath for Query? ",
                      :render_klass    => :trueclass,
                  },

                  :find_invisible =>
                   {
                      :value           => false,
                      :root_pan        => :action_data_panel,
                      :user_string     => "Include Invisible Elements? ",
                      :render_klass    => :trueclass,
                  },

                  :ele_index   =>
                  {
                      :root_pan        => :action_data_panel,
                      :user_string     => "Use Specific Element Index: ",
                      :render_klass    => :integer,
                      #initial value, min, max, step
                      :ele_args        => [ -1, -1, 10, 1 ],
                      :value           => nil,
                      :nil_value       => -1
                  },

                  :wait_mode =>
                  {
                      :root_pan        => :action_data_panel,
                      :user_string     => "Select Wait Mode: ",
                      :render_klass    => :symbolselect,
                      :ele_args        => [ :none, :wait_until_present, :wait_while_present ],
                      :value           => :none
                  },

                  :timeout   =>
                  {
                      :root_pan        => :action_data_panel,
                      :user_string     => "Enter Wait Timeout: ",
                      :render_klass    => :integer,
                      #initial value, min, max, step
                      :ele_args        => [ 1, 1, 30, 1 ],
                      :value           => 1
                  },

                  :raise_error   =>
                  {
                      :value           => true,
                      :root_pan        => :action_data_panel,
                      :user_string     => "Raise Error if Element not Found? ",
                      :render_klass    => :trueclass,
                  }

              }.merge!( other_data )

        super( data )

    end

end
