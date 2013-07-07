

module LoadSaveModule

    def save_to_disk()
        lambda{ |filename|
            begin
                filename = File.extname( filename ).empty? ? "#{filename}.test" : filename
                save_data = @trainer_actions.map do |trainer_action| trainer_action.to_disk end
                write_data_to_yaml_file( filename, save_data )
                alert_pop("Saved Test to : #{filename}")
            rescue => err
                alert_pop_err( err, 'Save Test Error:' )
            end
        }
    end

end
