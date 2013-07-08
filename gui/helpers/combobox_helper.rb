

  class ComboBoxHelper

        include ArgsHelper
        include MonkeyBarsHelper

        attr_accessor :selected, :gui_element, :options, :on_select_lambda, :clear
        attr_accessor :clear_listeners

        def initialize( args = {} )

            @args = args


            @gui_element = nil          #<----  the java jlist gui element
            @options = nil              #<----  the options we provide in this jlist
            @selected = nil             #<----  the selected jlist element
            @on_select_lambda = nil     #<----  run when combobox is changed.
                                        #<----  this lambda needs to accept a variable
                                        #<----  which will be the selected item

            @clear = false
            @clear_listeners = false    #<----  when true we clear existing listeners
                                        #<----  on gui_element before add new ones

            load_object_args(@args)

            init_combobox()
        end

        def get_selected()
            @gui_element.getSelectedItem
        end

        def get_selection_lambda()
            lambda do
                @selected = get_selected
                @on_select_lambda.call( @selected ) if @on_select_lambda
            end
        end

        def init_gui_element()
            return if !@gui_element.is_a?( Symbol )
            @gui_element = get_gui_element_from_handle( @gui_element )
        end
        
        def do_clear_listeners()
            listeners = @gui_element.getActionListeners
            return if listeners.length == 0

            listeners.to_a.each do |listen_obj|
                @gui_element.removeActionListener( listen_obj )
            end

        end

        def init_listeners()            
            @gui_element.addActionListener( GenericActionListener.new( get_selection_lambda ) ) if @on_select_lambda
        end

        def init_combobox()

            init_gui_element
            do_clear_listeners if @clear_listeners

            @gui_element.removeAllItems if @clear
            @options.each do |option| @gui_element.add_item( option.to_s ) end
            @gui_element.setSelectedItem( @selected ) if @selected

            init_listeners()
        end
    end
