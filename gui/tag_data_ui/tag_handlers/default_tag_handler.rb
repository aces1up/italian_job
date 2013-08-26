

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
                        #initial value, min, max, step
                        :ele_args       => [ 0, 0, 150, 1 ]
                  },

            :downcase =>
                  {
                        :value          => false,
                        :nil_value      => false,
                        :user_string    => 'Downcase All Characters: ',
                        :pan_x          => 400,
                        :pan_y          => 30,
                        :render_klass   => :trueclass,
                  },

            :upcase =>
                  {
                        :value          => false,
                        :nil_value      => false,
                        :user_string    => 'Capitalize All Characters: ',
                        :pan_x          => 400,
                        :pan_y          => 30,
                        :render_klass   => :trueclass,
                  },

            :escape_double_quotes =>
                  {
                        :value          => false,
                        :nil_value      => false,
                        :user_string    => 'Escape Double Quotes: ',
                        :pan_x          => 400,
                        :pan_y          => 30,
                        :render_klass   => :trueclass,
                  }



        }

        other_data.merge!( default_data )

        other_data
    end

end