

class ActionJtableMouseListener < MouseAdapter

    def action_jtable()
        DashboardUiController.instance.get_gui_handle( :actions_table )
    end

    def test_runner_obj()
        DashboardUiController.instance.get_model_var( :test_runner )
    end

    def set_selected_action( sel_row )
        test_runner_obj.set_selected( sel_row )
    end

    def mouseClicked(e)

        sel_row = action_jtable.rowAtPoint( e.getPoint() )
        action_jtable.clearSelection()
        action_jtable.addRowSelectionInterval( sel_row, sel_row )
        set_selected_action( sel_row.to_i )

        if (SwingUtilities.isRightMouseButton(e))
            #TrainerGuiController.instance.get_gui_handle(:action_jtable_conext_popup).show(e.getComponent(), e.getX(), e.getY())
        end

        if (SwingUtilities.isLeftMouseButton(e))
            Thread.new { 
                selected_action = test_runner_obj.selected_obj
                puts "rendering selected action: #{selected_action.obj_info}"
                selected_action.render_trainer_data if selected_action
             }
        end

    end

  end
