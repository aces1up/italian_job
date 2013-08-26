
#attr_accessor :headers, :post_body, :packet_filename, :method, :url, :content_type, :encode_mode
#attr_accessor :test_proxy
 #:multipart
 #:urlencoded
 #:direct

class RawPostTrainer < TrainerAction

    def self.trainer_data()

        data = {

                  :use_cookies =>
                  {
                      :root_pan        => :action_data_panel,
                      :user_string     => "Transfer Cookies Before Submit? ",
                      :render_klass    => :trueclass,
                      :value           => true
                  },

                  :packet_filename =>
                  {
                      :value           => nil,
                      :nil_value       => '',
                      :root_pan        => :action_data_panel,
                      :user_string     => "Packet Filename ( Optional ): ",
                      :render_klass    => :string,
                      :pan_y           => 50
                  },
                                    
                  :method =>
                  {
                      :root_pan        => :action_data_panel,
                      :user_string     => "Submit Method: ",
                      :render_klass    => :symbolselect,
                      :ele_args        => [ :post, :get, :put ],
                      :value           => :post
                  },

                  :url =>
                  {
                      :value           => '',
                      :nil_value       => '',
                      :root_pan        => :action_data_panel,
                      :user_string     => "Submit URL: ",
                      :render_klass    => :string,
                  },

                  :content_type =>
                  {
                      :root_pan        => :action_data_panel,
                      :user_string     => "Post Body Content Type: ",
                      :render_klass    => :symbolselect,
                      :ele_args        => [ :multipart, :urlencoded, :direct ],
                      :value           => :urlencoded
                  },


                  :encode_mode =>
                  {
                      :root_pan        => :action_data_panel,
                      :user_string     => "Post Body Content Type: ",
                      :render_klass    => :symbolselect,
                      :ele_args        => [ :autodetect, :cgi_encode, :url_encode ],
                      :value           => :autodetect
                  },

                  :headers =>
                  {
                      :value           => '',
                      :root_pan        => :action_data_panel,
                      :user_string     => "Headers: ",
                      :render_klass    => :textarea,
                      :pan_y           => 175,
                      :auto_resize     => false
                  },

                  :post_body =>
                  {
                      :value             => '',
                      :root_pan          => :action_data_panel,
                      :user_string       => "Post Body: ",
                      :render_klass      => :textarea,
                      :pan_y             => 175,
                      :auto_resize       => false,
                      :convert_to_string => true
                  },

                  :test_proxy =>
                  {
                      :value           => nil,
                      :nil_value       => '',
                      :root_pan        => :action_data_panel,
                      :user_string     => "Test Proxy: ",
                      :render_klass    => :string,
                  }                  

               }

        super( data )

    end
end
