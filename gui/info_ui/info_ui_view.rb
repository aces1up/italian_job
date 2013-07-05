class InfoUiView < ApplicationView
    set_java_class 'gui.info_ui.InfoDash'

    define_signal :name => :get_gui_handle, :handler => :get_gui_handle
    def get_gui_handle(model, transfer)
       return self.get_field_value( transfer[:gui_element] )
    end

    define_signal :name => :clear_jtree, :handler => :clear_jtree
    def clear_jtree( model, transfer )
      tree_model = DefaultTreeModel.new( DefaultMutableTreeNode.new( 'Refreshing...') )
      var_jtree.setModel( tree_model )
    end

    define_signal :name => :do_var_init_jtree, :handler => :do_var_init_jtree
    def do_var_init_jtree( model, transfer )

      clear_jtree( nil, nil )

      root_node  = RootVarNode.new()
      tree_model = DefaultTreeModel.new( root_node )
      var_jtree.setModel( tree_model )

    end

    define_signal :name => :init_variable_jtree, :handler => :init_variable_jtree
    def init_variable_jtree( model, transfer )

        jtree       = send( transfer[ :jtree_handle ] )
        jtree_data  = transfer[ :jtree_data ]

        tree_model = DefaultTreeModel.new( DefaultMutableTreeNode.new( 'Refreshing...') )
        jtree.setModel( tree_model )

        tree_model = DefaultTreeModel.new( JtreeHashDefaultNode.new( jtree_data ) )
        jtree.setModel( tree_model )

    end
end
