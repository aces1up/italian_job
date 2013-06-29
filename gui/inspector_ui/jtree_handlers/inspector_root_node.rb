

class RootNode < InspectorNode

    def init_info_node()
    end

    def to_data()
        {:url => @url}
    end

    def toString()
        "Body"
    end

end
