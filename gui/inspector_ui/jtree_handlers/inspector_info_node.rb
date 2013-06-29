

class InspectorInfoNode < InspectorNode

    #def get_form_index()
    #    @r_node.forms.find_index{|form_ele| form_ele.element_hint == @r_node.element_hint}
    #end

    #def add_form_index_node()
    #    return if @tag != 'form'
    #    @i_children << AttributeNode.new(@r_node, self, @tag, :form_index, get_form_index )
    #end

    #def add_input_index_node()
    #    return if @tag != 'input'
    #end

    def init_node()
        return if @node_initialized

        #add_form_index_node()
        @element.attributes.each do |attr, value|
            @i_children << InspectorAttributeNode.new( @element, @show_invisible, self, attr, value )
        end
        @node_initialized = true
    end

    def toString()
        "Attributes:   "
    end

end
