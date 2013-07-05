

class JtreeHashDefaultNode < DefaultMutableTreeNode

    def initialize( variable, parent=nil, init_value=nil )

        @variable           = variable
        @value              = init_value || nil

        @i_parent           = parent     #<--- jtree mutablenode parent of this node.
        @i_children         = []
        @i_allowchildren    = true

        @is_leaf            = false

        super()

    end
=begin
    def init_hash_children( hash_var )

        case
            when !hash_var.is_a?( Hash )
                @value = hash_var

            when hash_var.length == 1
                @value = hash_var.first.first
                @i_children << JtreeHashDefaultNode.new( hash_var.first.last, self )

        else
            hash_var.each do | key, val |

                case
                     when  ( val.is_a?(Hash) and val.empty? ) ; next
                     when  val.is_a?*
                send_hash = val.is_a?( Hash ) ? val : { key => val }
                @i_children << JtreeHashDefaultNode.new( send_hash, self, key )

            end
        end

    end
=end
    def init_hash()
        @variable.each do |key, val|
            @i_children << JtreeHashDefaultNode.new( val, self, key )
        end
    end

    def init_array()
        @variable.each do |val|
            @i_children << JtreeHashDefaultNode.new( val, self )
        end
    end

    def init_elements()
        #init_hash_children( @hash )
        case @variable.class.to_s.downcase.to_sym
            when :hash   ; init_hash
            when :array  ; init_array
        else
            if @value
                @i_children << JtreeHashDefaultNode.new( @variable, self )
            else
                @value = @variable
            end
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
        @i_parent.nil? ? 'Root' : @value.inspect
    end
end
