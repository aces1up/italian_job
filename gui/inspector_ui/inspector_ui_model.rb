class InspectorUiModel

    attr_accessor :conn

    def initialize()
        @conn = nil    #<--- this is the connection handle the jtree is rendering
                       #<--- current elements for.
    end

end
