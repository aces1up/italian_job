

class ActionTableRenderer < javax.swing.table.DefaultTableCellRenderer

    def initialize( jtable, table_model )

        @column      = :status
        @table_model = table_model

        super()

        init_renderer( jtable )
    end

    def init_renderer(jtable)
        return if !jtable
        jtable.getColumnModel.getColumns.to_a.each do |table_column_obj|
            table_column_obj.setCellRenderer(self)
        end
    end

    def render_default()
        #this function should be implemented on subclasses
        #for the default color / render for
        #a column we can't find data for
        setForeground(Color::BLACK)
        setBackground(Color::WHITE)
    end

    def do_render(row)

        case @table_model.data[ row ].status

            when :running
                setForeground(Color::BLACK)
                setBackground(Color::CYAN)

            when :success
                setForeground(Color::BLACK)
                setBackground(Color::GREEN)

            when :error
                setForeground(Color::BLACK)
                setBackground(Color::RED)

            when :connection_error
                setForeground(Color::BLACK)
                setBackground(Color::YELLOW)

            when :captcha_error
                setForeground(Color::BLACK)
                setBackground(Color::ORANGE)

        else
            render_default
        end
    end

    def render_value(row)
      begin
        #first check to see if we have a value for
        #the render column we are looking at.. If not
        #run our defualt render function.
        do_render(row)

      rescue => err
          alert_pop_err( err, "Action Table Render Error: ")
          render_default()
      end
    end

    def getTableCellRendererComponent(table, value, isSelected, hasFocus, row, column)
          render_value(row)
          super(table, value, isSelected, hasFocus, row, column)
    end
end


