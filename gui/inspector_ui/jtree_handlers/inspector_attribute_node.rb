

class InspectorAttributeNode < InspectorNode

    attr_reader :val

    def initialize( element, show_invisible, parent, attr, val)
        @attr = attr
        @val = val
        super( element, show_invisible, parent )
    end

    def init_node()
    end

    def toString()
        "#{@attr} : #{@val.inspect}"
    end

    def isLeaf()
      true
    end
end
