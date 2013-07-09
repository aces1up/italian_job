

module LoadSaveModule

    def load_test( filename )
        begin
            test_data = load_yaml_from_file( filename )

            test_data.each do |action_data|

                action_klass = get_constant( "#{action_data[:klass]}Trainer" )
                raise TestLoadError, "Cannot Get Trainer Action Class for #{action_data[:klass]}" if !action_klass

                #add the trainer action here
                add_action( action_klass, action_data[:data] )

            end
        rescue => err
            alert_pop_err( err, "Error Loading Test File: #{filename}: " )
        end
    end


    def save_to_disk()
        #returns true if there was error, else returns false
        #when we saved successfully...

        lambda{  |filename|
            begin

                if @trainer_actions.empty?()
                    alert_pop("Cannot Save Test, no Actions Currently Loaded!")
                    return true
                end

                save_data = @trainer_actions.map do |trainer_action| trainer_action.to_disk end
                write_data_to_yaml_file( filename, save_data )
                alert_pop("Saved Test to : #{filename}")
                false

            rescue => err
                alert_pop_err( err, 'Save Test Error:' )
                true
            end
        }
    end

    def load_profile_from_disk( filename )
        begin
            load_yaml_from_file( filename )
        rescue => err
            alert_pop_err( err, 'Load Profile Error: ')
        end
    end

    def save_profile_to_disk()

        lambda{  |filename|
            begin

                if !has_profile?
                    alert_pop("Cannot Save Profile, no Profile Data Currently Loaded!")
                    return true
                end

                save_data = @test_thread.container_data(:acct)
                write_data_to_yaml_file( filename, save_data )
                alert_pop("Saved Profile Data to : #{filename}")
                false

            rescue => err
                alert_pop_err( err, 'Save Profile Error:' )
                true
            end
        }

    end

end
