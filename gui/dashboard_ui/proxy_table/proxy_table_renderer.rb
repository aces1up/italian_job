
import java.awt.Color

class ProxyTableRenderer < javax.swing.table.DefaultTableCellRenderer

    def initialize(jtable, table_model)

        @column      = :validated
        @table_model = table_model

        super()

        init_renderer(jtable)
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

        case @table_model.data[ @table_model.data.keys[row] ][@column]

          when :not_validated ; render_default

          when :testing
                setForeground(Color::BLACK)
                setBackground(Color::CYAN)

          when :success
                setForeground(Color::BLACK)
                setBackground(Color::GREEN)
        end
    end

    def render_value(row)
      begin
        #first check to see if we have a value for
        #the render column we are looking at.. If not
        #run our defualt render function.
        do_render(row)

      rescue => err
          render_default()
      end
    end

    def getTableCellRendererComponent(table, value, isSelected, hasFocus, row, column)
          render_value(row)
          super(table, value, isSelected, hasFocus, row, column)
    end
end

