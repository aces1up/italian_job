

  class ComboBoxHelper

        include ArgsHelper
        include MonkeyBarsHelper

        attr_accessor :selected, :gui_element, :options, :on_select_lambda, :clear

        def initialize( args = {} )

            @args = args


            @gui_element = nil          #<----  the java jlist gui element
            @options = nil              #<----  the options we provide in this jlist
            @selected = nil             #<----  the selected jlist element
            @on_select_lambda = nil     #<----  run when combobox is changed.
                                        #<----  this lambda needs to accept a variable
                                        #<----  which will be the selected item

            @clear = false

            load_object_args(@args)

            init_combobox()
        end

        def get_selection_lambda()
            lambda do
                @selected = @gui_element.getSelectedItem
                @on_select_lambda.call( @selected ) if @on_select_lambda
            end
        end

        def init_gui_element()
            return if !@gui_element.is_a?( Symbol )
            @gui_element = get_gui_element_from_handle( @gui_element )
        end

        def init_combobox()

            init_gui_element

            @gui_element.removeAllItems if @clear
            @options.each do |option| @gui_element.add_item(option.to_s) end
            @gui_element.setSelectedItem( @selected ) if @selected
            @gui_element.addActionListener( GenericActionListener.new( get_selection_lambda ) ) if @on_select_lambda
        end
    end
