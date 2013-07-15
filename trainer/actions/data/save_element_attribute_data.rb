
class SaveElementAttributeTrainer < TrainerAction

    extend ElementTrainerData

    def self.trainer_data()

        data = {
                  :save_attr =>
                  {
                      :root_pan        => :action_data_panel,
                      :user_string     => "Enter Attribute of Element to Save: ",
                      :render_klass    => :symbol,
                      :pan_y           => 50
                  }
        }

        super( data )

    end

    extend SaveVarData

end
