class DashboardUiModel

    attr_accessor :test_runner, :action_table_model, :action_list_combo
    attr_accessor :profile_list_combo, :file_list_combo

    def initialize()

        #gui Handles
        @action_table_model    =   nil
        @action_list_combo     =   nil
        @profile_list_combo    =   nil
        @file_list_combo       =   nil

        @test_runner           =   nil
    end

    def on_file_combo_select_lambda()
        lambda { |file_selected|
            puts "got file selected : #{file_selected}"
        }
    end

    def on_profile_combo_select_lambda()

        lambda { |profile_selected|
            puts "got profile Selected: #{profile_selected}"
        }

    end

end
