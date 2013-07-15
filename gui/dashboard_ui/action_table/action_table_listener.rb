

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

    def confirmation_email()
        #retrieves the confirmation email
        obj = test_runner_obj
        return nil if ( !obj or !obj.test_thread or !obj.test_thread.has_var_mediator? )
        obj.test_thread.get_var( :email_text )
    end

    def menu()
        {
            'Edit Action Data' => {
                 :lam_block => lambda { show_edit_data_window },
                 :run_in_thread => false
            },

            'Run Action'       => {
                :lam_block => lambda { test_runner_obj.run_single_action }
            },

            'Action LOG'       => {
                :lam_block => lambda {
                      obj = test_runner_obj.selected_obj
                      obj.render_log if obj
                }
            },

             'Set Breakpoint'       => {
                :lam_block => lambda {
                      obj = test_runner_obj.selected_obj
                      obj.set_breakpoint if obj
                }
            },

            'Clear Breakpoint'       => {
                :lam_block => lambda {
                      obj = test_runner_obj.selected_obj
                      obj.clear_breakpoint if obj
                }
            },

            'Show Confirmation Email' => {
                :lam_block => lambda {
                      if ( email_text = confirmation_email )
                           DashboardUiController.instance.show_log( email_text )
                      else
                           alert_pop( 'No Confirmation Email Currently Stored!' )
                      end
                }
            }
        }
    end
    
    def init_menu()
        @menu_handler ||= MenuHelper.new( menu )
        @menu_handler 
    end

    def show_edit_data_window()
        Thread.new {
           selected_action = test_runner_obj.selected_obj
           selected_action.render_trainer_data if selected_action
        }
    end

    def mouseClicked(e)

        click_count = e.getClickCount

        sel_row = action_jtable.rowAtPoint( e.getPoint() )
        action_jtable.clearSelection()
        action_jtable.addRowSelectionInterval( sel_row, sel_row )
        set_selected_action( sel_row.to_i )

        case

            when click_count.to_i == 2
                 #show data window on double click
                 show_edit_data_window

            #when SwingUtilities.isLeftMouseButton(e)
            #     show_edit_data_window

            when SwingUtilities.isRightMouseButton( e )
                 #show our context menu
                 init_menu
                 @menu_handler.render_menu( e.getComponent(), e.getX(), e.getY() )
            
        end

    end

  end
