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
        handler_klass = get_constant( "#{@tag_selected.to_s.gsub('_','').capitalize}TagHandler" )
        handler_klass ||= TagHandler
        handler_klass
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
    
    def selected_tag_to_s()
        "~~#{@tag_selected.to_s}~~"
    end

    def append_tag()
        #this will append the tag to the currently selected
        #action_data focused field
        action_data_container.get_focused_handler.append_value( selected_tag_to_s )
    end

    def export_data()
        @tag_data.all_vars.delete_if{ |var, value| value.nil? }
    end

    def export_tag_data()
        #this will export our current @tag_data to the currently
        #focused action data and
        if @tag_data
            @tag_data.save
            action_data_container.import_tag_data( action_data_container.focused, @tag_selected, export_data )
        end
    end

end
