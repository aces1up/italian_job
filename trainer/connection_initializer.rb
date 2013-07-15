

module ConnectionInitializer

  def teardown_connections()
      # tears down the connections associated with
      # @test_thread
      begin
          @test_thread.teardown_thread_connections if @test_thread
      rescue => err
          alert_pop_err( err, 'Error Cleaning Up Previous Test Connections!' )
      end
  end

  def browser_type()
      #get browser type from the gui setting
      get_gui_element_from_handle( :connection_type_combo ).getSelectedItem.downcase.to_sym
  end

  def use_proxies?()
      get_gui_element_from_handle( :use_proxies_checkbox ).isSelected
  end

  def set_connection_class()
      @connection_class = browser_type == :socket ? MechanizeConnection : EasyriderConnection
  end

  def setup_use_proxies()
      @connection_options.merge!( { :use_local_proxy => true } ) if !use_proxies?
  end

  def setup_connection_options()
      @connection_options = {}
      setup_use_proxies()
      @connection_options.merge!( :browser_type => browser_type ) if browser_type != :socket
  end

  def setup_connection()

      #these connection options setup the global options
      #which are loaded during the action initialization

      set_connection_class()
      setup_connection_options()

  end

end
