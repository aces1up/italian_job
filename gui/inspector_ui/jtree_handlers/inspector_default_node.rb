  
  class InspectorNode < DefaultMutableTreeNode

    include InspectorMenuHandler

    def initialize( element, show_invisible=false, parent=nil )

        @element            = element
        @i_children         = []
        @i_allowchildren    = true
        @i_parent           = parent     #<--- jtree mutablenode parent of this node.
        @show_invisible     = show_invisible

        super()
    end

    def test_runner_obj()
        DashboardUiController.instance.get_model_var( :test_runner )
    end

    def filter_selected?()
        InspectorUiController.instance.filter_selected?
    end

    def filter_selected()
        InspectorUiController.instance.filter_selected.to_sym
    end

    def element_method()
        filter_selected? ? :elements_for_tag_name : :children_for_element
    end
    
    def menu( other_data={} )
        #this is a hash struct with key being the menu name
        #and a lambda to perform when its clicked.
        {
            'Click Element'      => lambda { @element.click },
            'Set Element'        => lambda {
                val = get_info_dialog( 'Set Element', 'Enter Value to Set on Element: ' )
                if val ; @element.set( val ) end
             },
            'Set Key'        => lambda {
                val = get_info_dialog( 'Send Key to Element', 'Enter Key to Send to Element: ' )
                if val ; @element.set_key( val ) end
             },

             'Fire Event'        => lambda {
                val = get_info_dialog( 'Fire Event on Element', 'Enter event to Send to element: ' )
                if val ; @element.fire_event( val ) end
             },
            'Hover on Element'     => lambda { @element.hover },
            'Hover On Element JS'  => lambda { @element.hover_js },
            'Focus'                => lambda { @element.focus },
            'Flash Element'        => lambda {
                num_times = get_info_dialog( 'Flash Element', 'Enter Number of Times to Flash Element: ' )
                interval  = get_info_dialog( 'Flash Element', 'Enter Interval Between Flashes: ' )
                if num_times and interval
                  @element.flash( num_times, interval )
                end
            },

            'Set Drag From'       => lambda { $from = @element },
            'Drag to'             => lambda { $from.drag_to @element }
            
        }.merge!( other_data )
    end

    def get_elements()
        if filter_selected?
            @element.elements_for_tag_name( filter_selected, @show_invisible )
        else
            @element.children_for_element( @show_invisible )
        end
    end


    def init_elements()
      
        get_elements.each do | child_element |
            @i_children << InspectorNode.new( child_element, @show_invisible, self )
        end

    end

    def init_info_node()
        @i_children << InspectorInfoNode.new( @element, @show_invisible, self )
    end

    def init_node()
        return if @node_initialized
        init_info_node()
        init_elements()
        @node_initialized = true
    end

    #  Methods to satisfy the TreeNode interface
    def getAllowsChildren()
        #puts "get allows children"
        @i_allowchildren
    end

    def children()
        #puts "children method"
        @i_children
    end

    def getChildAt( index )
        #puts "get child at #{index}"
        init_node 
        @i_children[index]
    end

    def getChildCount()
        #puts "get child count"
        init_node 
        @i_children.length
    end

    def getIndex(node)
        #puts "get index: #{node.obj_info}"
        init_node
        @i_children.index(node)
    end

    def getParent()
        #puts "doing get parent"
        @i_parent
    end

    def isLeaf()
        super
    end


    #  Methods to satisfy MutableTreeNode interface
    def insert(node, index)
        #puts "doing insert: #{node.inspect} -- index: #{index}"
        super(node, index)
    end

    def setParent( node )
        #puts "setting parent: #{node.obj_info}"
        @i_parent = node
    end

    def get_str_attr( attr )
        val = @element.attribute_value( attr )
        return "" if val.nil? or val.empty?
        " -- [ #{attr.to_s}: #{val} ]"
    end

    def toString()
        @str ||= "#{@element.tag_name.upcase}#{get_str_attr( :id )}#{get_str_attr( :class )}"
        @str
    end

=begin
    def remove()
    def removeFromParent()
    def getUserObject()
    def setUserObject()
=end


end

