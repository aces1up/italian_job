class DashboardUiModel

    attr_accessor :test_runner, :action_table_model, :action_list_combo

    def initialize()

        #gui Handles
        @action_table_model    =   nil
        @action_list_combo     =   nil

        @test_runner           =   nil
    end

end
