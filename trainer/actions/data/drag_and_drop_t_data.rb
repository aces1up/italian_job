



class DragandDropTrainer < TrainerAction

    extend ElementTrainerData

    def self.trainer_data()

        data = {

                  :dropto_method    =>
                  {
                      :value           => "",
                      :nil_value       => "",
                      :root_pan        => :action_data_panel,
                      :user_string     => "Enter Dom Method to find Dropto Element: ",
                      :render_klass    => :symbol,
                      :pan_y           => 50
                  },

                  :dropto_how    =>
                  {
                      :value           => "",
                      :nil_value       => "",
                      :root_pan        => :action_data_panel,
                      :user_string     => "Enter Attribute to find Dropto Element: ",
                      :render_klass    => :symbol,
                      :pan_y           => 50
                  },

                  :dropto_what    =>
                  {
                      :value           => "",
                      :nil_value       => "",
                      :root_pan        => :action_data_panel,
                      :user_string     => "Enter What to Search for to find Dropto SubElement: ",
                      :render_klass    => :string,
                      :pan_y           => 50
                  },

                  :dropto_match_type =>
                  {
                      :root_pan        => :action_data_panel,
                      :user_string     => "Select dropto Element Match Type: ",
                      :render_klass    => :symbolselect,
                      :ele_args        => [ :exact, :broad ],
                      :value           => :broad
                  },

                  :dropto_wait_mode =>
                  {
                      :root_pan        => :action_data_panel,
                      :user_string     => "Select dropto Element Wait Mode: ",
                      :render_klass    => :symbolselect,
                      :ele_args        => [ :none, :wait_until_present, :wait_while_present ],
                      :value           => :none
                  },

                  :dropto_timeout   =>
                  {
                      :root_pan        => :action_data_panel,
                      :user_string     => "Enter Wait Timeout for dropto Element: ",
                      :render_klass    => :integer,
                      #initial value, min, max, step
                      :ele_args        => [ 1, 1, 30, 1 ],
                      :value           => 1
                  }

        }

        super( data )
    end

end
