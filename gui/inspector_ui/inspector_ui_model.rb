class InspectorUiModel

    attr_accessor :conn, :filter_combo

    def initialize()
        @conn = nil    #<--- this is the connection handle the jtree is rendering
                       #<--- current elements for.

        @filter_combo = nil
    end

end
