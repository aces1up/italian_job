

class ContainerNode < DefaultMutableTreeNode

    def initialize( container_name=nil, container_obj=nil, parent=nil )

        @container_name     = container_name
        @container_obj      = container_obj

        @i_parent           = parent     #<--- jtree mutablenode parent of this node.
        @i_children         = []
        @i_allowchildren    = true

        super()
    end

    def init_elements()

        @container_obj.data.each do | var_name, val |
            @i_children << VariableNode.new( var_name, val, self )
        end

    end

    def init_node()
        return if @node_initialized
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

    def toString()
        #@str ||= "#{@element.tag_name.upcase}#{get_str_attr( :id )}#{get_str_attr( :class )}"
        #@str
        @container_name.to_s.upcase
    end
end
