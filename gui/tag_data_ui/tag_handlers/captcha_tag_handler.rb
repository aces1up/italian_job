

class CaptchaTagHandler < TagHandler

    def self.tag_data()
        data = {
            :use_cookies =>
                  {
                       :value           => true,
                       :user_string     => 'Use Cookies when Fetching Image?',
                       :pan_x           => 400,
                       :pan_y           => 35,
                       :render_klass    => :trueclass,
                  },

            :is_recaptcha =>
                  {
                        :value       => false,
                        :user_string => 'Is ReCaptcha Image?',
                        :pan_x       => 400, :pan_y => 35,
                        :render_klass => :trueclass,
                  },

            :public_key  =>
                  {
                      :value         => nil,
                      :nil_value     => '',
                      :user_string   => 'Recaptcha Public Key( Optional )',
                      :pan_x         => 400, :pan_y => 55,
                      :render_klass  => :string,
                  },

            :use_url =>
                  {
                        :value          => nil,
                        :user_string    => 'Use Manual Tag/URL: ',
                        :nil_value      => "",
                        :pan_x          => 400,
                        :pan_y          => 55,
                        :render_klass   => :string,
                  },

            :image_coords =>
                  {
                        :value          => nil,
                        :user_string    => 'Snag Crop of Captcha (X, Y, Right, Bottom): ',
                        :nil_value      => "",
                        :pan_x          => 400,
                        :pan_y          => 55,
                        :render_klass   => :string,
                  },

            :search_for =>
                  {
                        :value          => [],
                        :user_string    => 'Enter list of search Strings to find Captcha Image.',
                        :ele_args       => [4, 25],
                        :pan_x          => 400,
                        :pan_y          => 100,
                        :render_klass   => :textarea,
                  }
        
        }
        super( data )
    end

end
