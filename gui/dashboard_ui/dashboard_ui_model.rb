class DashboardUiModel

    include KillAllPhantom

    attr_accessor :test_runner, :action_table_model, :action_list_combo
    attr_accessor :profile_list_combo, :file_list_combo, :proxy_table_model

    def initialize()

        #gui Handles
        @action_table_model    =   nil
        @proxy_table_model     =   nil

        @action_list_combo     =   nil
        @profile_list_combo    =   nil
        @file_list_combo       =   nil

        @test_runner           =   nil
    end

    def init_test_runner()
        @test_runner = TestRunner.new
    end

    def ask_load_test?( filename )
        get_yes_no( 'Confirm Load Test', "You Sure you want to Load Test:\n#{filename}?" )
    end

    def load_test( filename )

        @test_runner.teardown
        kill_phantom_js()
        init_test_runner()

        @action_table_model.reset_model
        
        return if filename == 'none'
        @test_runner.load_test( filename )
    end

    def on_file_combo_select_lambda()
        lambda { |file_selected|
            filename = file_selected == 'none' ? file_selected : "#{TestsDirectory}#{file_selected}"
            load_test( filename ) if ask_load_test?( filename )
        }
    end

    def on_profile_combo_select_lambda()
        lambda { |profile_selected| }
    end

    #file Save Button Stuff

    def get_save_file_from_chooser( directory )
        FileChooserHelper.new( nil, directory, true ).file
    end

    def get_save_filename( combobox, directory )

        selected_file = combobox.selected
        
        save_file = selected_file == 'none' ? selected_file : "#{directory}#{selected_file}"

        if save_file == 'none'  
              save_file = get_save_file_from_chooser( directory )
        else              
              overwrite = get_yes_no( 'Confirm Save Overwrite', "Are you sure you want to overwrite : #{save_file}?" )
              save_file = get_save_file_from_chooser( directory ) if !overwrite
        end

        save_file.gsub('\\', '/').downcase if save_file
        save_file

    end

end
