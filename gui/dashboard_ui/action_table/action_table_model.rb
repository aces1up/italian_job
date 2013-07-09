


class ActionTableHandler < javax.swing.table.DefaultTableModel

  include GetValueAtHelperModule

  def initialize()

    @columns ||= {
          :action         => 100,
          :output         => 350,
          :status         => 30,
          :has_run        => 30,
          :breakpoint     => 30
    }

    @gui_element = DashboardUiController.instance.get_gui_handle( :actions_table )
    @renderer    = nil
    super()

    init()
  end

  def init()
      init_columns()
      init_model()
      init_column_widths()
      init_renderer()
      update()
  end

  def clear_renderer()
      @renderer.clear_renderer
  end
  
  def clear_model()
      @gui_element.model = javax.swing.table.DefaultTableModel.new
      update()
  end

  def init_model()
      @gui_element.model = self
  end

  def reset_model()
      clear_model
      clear_renderer
      init()
  end

  def data()
      DashboardUiController.instance.get_model_var( :test_runner ).trainer_actions
  end

  def init_renderer()
      @renderer = ActionTableRenderer.new( @gui_element, self )
  end

  def init_column_widths()
      colmodel = @gui_element.getColumnModel()
      @columns.each do |column, size|
            begin
                  col_index = colmodel.getColumnIndex( column.to_s )
                  col = colmodel.getColumn( col_index )
                  col.setPreferredWidth( size )
            rescue => err
                alert_pop_err( err, "Error Initializing Action Table Column:" )
            end
       end
  end

  def init_columns()
       @columns.each do |column, size| add_column( column ) end
  end

  def getColumnCount
    #make sure we only return the count for the number of
    #columns that are set as shown.
    @columns.length
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
