

module ValueConveter

      def from_gui_to_string()

          @value = case @render_klass

              when :string        ;   @value.to_s
                  #do our conversion to regex here
                  #if its enclosed in / /
              when :symbol        ;   @value.to_sym
              when :symbolselect  ;   @value.to_sym

          else
              #we have no conversion found so just return value
              @value
          end

      end

      def to_gui_from_string()
          @value = @value.to_s
      end

      def from_gui_to_array()
          if @var_args[:convert_to_string]
              @value  #<--- return @value as it should be string here
          else
              @value = @value.split( "\n" )
          end
      end

      def value_to_gui_textbox()

          @value = case
              when @value.nil?           ; ""
              when @value.is_a?( Array ) ; @value.join("\n")
          else
              @value.to_s
          end

      end
end
