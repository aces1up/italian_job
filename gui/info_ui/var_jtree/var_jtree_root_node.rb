

class RootVarNode < ContainerNode

    def init_elements()

        var_mediator = InfoUiController.instance.trainer_vars
        var_mediator.var_objs.each do |container_name, container_obj|
            @i_children << ContainerNode.new( container_name, container_obj, self )
        end

    end

    def init_info_node()
    end

    def toString()
        "Variable Conatiners"
    end

end
