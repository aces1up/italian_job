

class TagHandler
    def self.tag_data( other_data={} )

        default_data = {

            :truncate =>
                  {
                        :value          => 0,
                        :nil_value      => 0,
                        :user_string    => 'Truncate at Number of Words: ',
                        :pan_x          => 400,
                        :pan_y          => 30,
                        :render_klass   => :integer,
                  },

        }

        other_data.merge!( default_data )

        other_data
    end

end