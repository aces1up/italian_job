

class ProxyCache

    def update_gui()
        return if !Display_GUI

        #this is used inside our bot GUI functions
        #as a monkey patch to display GUI
        #info for this proxy table.
        DashboardUiController.instance.get_model_var( :proxy_table_model ).update
    end

end
