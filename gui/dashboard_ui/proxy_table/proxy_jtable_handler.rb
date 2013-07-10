

class ProxyTableHandler < javax.swing.table.DefaultTableModel

  include GetValueAtHelperModule

  def initialize()

    @columns ||= {
          :ip         => :shown,
          :port       => :shown,
          :username   => :shown,
          :password   => :shown,
          :validated  => :shown
    }

    @gui_element = DashboardUiController.instance.get_gui_handle( :proxy_table )
    @renderer    = nil
    super()

    init_columns()
    init_model()
    init_renderer()
  end

  def data()
      ProxyCache.instance.cache
  end

  def init_renderer()
      @renderer = ProxyTableRenderer.new( @gui_element, self )
  end

  def init_model()
      @gui_element.model = self
  end

  def init_columns()
      @columns.each do |column, column_type|
          add_column( column ) if column_type == :shown
      end
  end

  def getColumnCount
    #make sure we only return the count for the number of
    #columns that are set as shown.
    return @columns.count{|column, column_type| column_type == :shown}
  end

  def getRowCount
      return data.size
  end

  def isCellEditable(row, col)
      false
  end

  def getValueAt(row, col)
      column_var = col_to_sym( getColumnName(col) )
      begin
          data[ data.keys[row] ][column_var].to_s
      rescue => err
          puts "err getting value: #{row} / #{col}"
          "unknown"
      end
  end

  def update()
      fireTableDataChanged()
  end

end



