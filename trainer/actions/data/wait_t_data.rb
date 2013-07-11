


module WaitTrainerData

    def trainer_data( other_data={} )

        data = {

                  :wait_mode =>
                  {
                      :root_pan        => :action_data_panel,
                      :user_string     => "Select Wait Mode: ",
                      :render_klass    => :symbolselect,
                      :ele_args        => [ :none, :until_present, :while_present ],
                      :value           => :none
                  }

              }.merge!( other_data )

        super( data )

    end
end
