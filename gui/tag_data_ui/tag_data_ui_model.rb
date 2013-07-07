class TagDataUiModel
  
    attr_accessor :tag_selected, :tag_data

    def initialize()
        @tag_selected   = nil
        @tag_handler    = nil
        @tag_data       = nil
    end

    def clear_panel()
        @tag_data.clear_root_pan if @tag_data
    end

    def clear()
        clear_panel
        @tag_data    = nil
        @tag_handler = nil
    end

    def render()
        @tag_data.render
    end
    
    def tag_handler_klass()
        #gets the tag_handler class for our
        #current @tag_selected
        get_constant( "#{@tag_selected.to_s.gsub('_','').capitalize}TagHandler" )
    end

    def init_tag_data( init_data )
        @tag_data = GUIContainer.new( init_data, :tag_root_panel )
    end

    def render_tag_data()
        #clear our previous tag data to avoid corruption
        clear()

        if ( tag_handler = tag_handler_klass )
            init_tag_data( tag_handler.tag_data )
            render
        end
        
    end

    def action_data_container()
        TagDataUiController.instance.action_data_container
    end

    def export_data()
        { @tag_selected => @tag_data.all_vars }
    end

    def export_tag_data()
        #this will export our current @tag_data to the currently
        #focused action data and
        if @tag_data
            @tag_data.save
            action_data_container.import_tag_data( action_data_container.focused, export_data )
        end
    end

end
