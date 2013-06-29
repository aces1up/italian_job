class InspectorUiView < ApplicationView
  set_java_class 'gui.inspector_ui.Inspect'

  define_signal :name => :get_gui_handle, :handler => :get_gui_handle
  def get_gui_handle(model, transfer)
     return self.get_field_value( transfer[:gui_element] )
  end


  def load()
      inspect_jtree.addMouseListener( JtreeMouseListener.new( inspect_jtree ) )
  end

  define_signal :name => :clear_jtree, :handler => :clear_jtree
  def clear_jtree( model, transfer )
      tree_model = DefaultTreeModel.new( DefaultMutableTreeNode.new( 'Rendering...') )
      inspect_jtree.setModel( tree_model )
  end

  define_signal :name => :do_init_jtree, :handler => :do_init_jtree
  def do_init_jtree( model, transfer )

      clear_jtree( nil, nil )

      show_invisible = show_invisible_checkbox.isSelected

      root_node  = RootNode.new( transfer[:conn].root_element, show_invisible )
      tree_model = DefaultTreeModel.new( root_node )
      inspect_jtree.setModel( tree_model )

  end

end
