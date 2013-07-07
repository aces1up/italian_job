

class RandomlinefromfileTagHandler < TagHandler

    def self.tag_data()
        data = {

            :file =>
                  {
                       :value           => "",
                       :nil_value       => "",
                       :user_string     => 'Enter Filename to get Random Line From:',
                       :pan_x           => 400,
                       :pan_y           => 50,
                       :render_klass    => :string,
                  }

        }
        super( data )
    end

end



