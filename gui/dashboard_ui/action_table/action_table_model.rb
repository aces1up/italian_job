


class ActionTableHandler < javax.swing.table.DefaultTableModel

  include GetValueAtHelperModule

  def initialize()

    @columns ||= {
          :action         => :shown,
          :output         => :shown,
          :status         => :shown,
          :has_run        => :shown,
          :breakpoint     => :shown
    }

    @gui_element = DashboardUiController.instance.get_gui_handle( :actions_table )
    @renderer    = nil
    super()

    init_columns()
    init_model()
    init_renderer()
    update()
  end

  def data()
      DashboardUiController.instance.get_model_var( :test_runner ).trainer_actions
  end

  def init_renderer()
      @renderer = ActionTableRenderer.new( @gui_element, self )
  end

  def clear_model()
      @gui_element.model = javax.swing.table.DefaultTableModel.new
      update()
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
          if data[ row ].respond_to?( column_var )
              data[ row ].send( column_var ).to_s
          else
              "unknown"
          end
      rescue => err
          alert_pop_err(err, "Action Table Model GetValueAt Error:")
          "unknown"
      end

  end

  def update()
      fireTableDataChanged()
  end

end
