

class InspectorAttributeNode < InspectorNode

    attr_reader :val

    def initialize( element, show_invisible, parent, attr, val)

        @attr     = attr
        @val      = val
        @method   = element.tag_name.to_sym

        super( element, show_invisible, parent )
    end

    def menu()
        #this is a hash struct with key being the menu name
        #and a lambda to perform when its clicked.
        super(
               {
                  'Add Attribute to Selected Action'   => 
                      lambda {
                          obj = test_runner_obj.selected_obj
                          obj.import( to_action ) if obj
                      }
               }
              )
    end

    def from_inspector()
        # generates a hash representation of this node so it can be easily
        # loaded into the action that needs it
        {
            :method => @method,
            :how    => @attr.to_sym,
            :what   => @val
        }
    end
    alias_method :to_action, :from_inspector

    def init_node()
    end

    def toString()
        "#{@attr} : #{@val.inspect}"
    end

    def isLeaf()
      true
    end
end
