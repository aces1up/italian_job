

module ExportToLoadData

    def arr_to_str( arr )
        return nil if arr.empty?
        arr.join('|')
    end

    def hash_to_str( key, value )
        #converts a tag data key/value pair to
        #a string that can be appended to the tag_data string
        #we are creating
        value_str = case
            when value.nil?           ; nil
            when value.is_a?( Array ) ; arr_to_str( value )
        else
            value
        end

        value_str.nil? ? nil : "#{key}=#{value_str}"
    end

    def tag_to_str( tag, tag_data )
        tag_data_str = tag_data.map{ |var_name, value| hash_to_str( var_name, value ) }.compact
        "~~#{tag}?#{tag_data_str.join('?')}~~"
    end

    def var_args_to_str( var_args )

        var_args[:value].gsub!(/~~(.+?)~~/) { |tag|
            tag_match = $1.to_sym

            case
                #check to see if we have tag_data for the
                #current tag_match
                when ( var_args[:tag_data] and var_args[:tag_data][tag_match] )
                    tag_to_str( tag_match, var_args[:tag_data][tag_match] )
            else
                "~~#{tag_match.to_s}~~"
            end

        }
    end

    def all_vars_to_load_data()
        #does the conversion of our all vars to
        #data that can be loaded in the actual action data
        #creates a tag string of our tag data if it exists
        #so that the action will parse out the tag args properly
        #when executing.

        #need to ensure we encode array properly here
        vars = {}

        all_vars.each do |var_name, var_args|

            value = if var_args.is_a?( Hash )
                #we have a hash meaning we have tag data available
                #so we need to parse a string for the tag_data for
                #it to load properly in the action
                var_args_to_str( var_args )
            else
                var_args
            end

            vars[var_name] = value

        end
        vars
    end

end
