

class VariableNode < DefaultMutableTreeNode

    def initialize( var_name, val, parent=nil )

        @var_name           = var_name
        @val                = val

        @i_parent           = parent     #<--- jtree mutablenode parent of this node.
        @i_children         = []
        @i_allowchildren    = true

        super()
    end

    def init_elements()

    end


    def init_node()
        return if @node_initialized
        #init_info_node()
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
        true
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

    def val_to_str()

        case @val.class.to_s.downcase
          
            when 'string'   ; @val.to_s.inspect
            when 'fixnum'   ; @val.to_s.inspect
            when 'symbol'   ; @val.to_s.inspect
            when 'nilclass' ; "NIL"

        else
            @val.obj_info
        end
    end

    def toString()
        #@str ||= "#{@element.tag_name.upcase}#{get_str_attr( :id )}#{get_str_attr( :class )}"
        #@str
        "[ #{@var_name} ] : #{val_to_str} "
    end
end

