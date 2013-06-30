
module SaveVarData

    def trainer_data( other_data={} )

        other_data.merge!( {

                  :save_var    =>
                  {
                      :value           => "",
                      :nil_value       => "",
                      :root_pan        => :action_data_panel,
                      :user_string     => "Enter Variable Name to Save Value to: ",
                      :render_klass    => :symbol,
                      :pan_y           => 50
                  },

                  :save_to_temp =>
                  {
                      :value           => true,
                      :root_pan        => :action_data_panel,
                      :user_string     => "Save to Temp Variables? ",
                      :render_klass    => :trueclass,
                  },

                  :overwrite =>
                  {
                      :value           => true,
                      :root_pan        => :action_data_panel,
                      :user_string     => "Overwrite Variable it it Exists? ",
                      :render_klass    => :trueclass
                  }
        } )

        super( other_data )

    end
end
