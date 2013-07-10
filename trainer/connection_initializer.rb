

module ConnectionInitializer

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

  def setup_inspector()
      InspectorUiController.instance.set_model_var( :conn, current_connection_handle )
  end

  def setup_connection()

      set_connection_class()
      setup_connection_options()
      setup_inspector()

      #init the connection here
      #still need to figure out how we specify
      #specific connection options like
      #  :load_images
      #  :clear_cookies

      init_connector()   #<--- sets up out connection mediator and
                         #<--- starting connection from our botter
                         #<--- connection wrapper module

  end

end
