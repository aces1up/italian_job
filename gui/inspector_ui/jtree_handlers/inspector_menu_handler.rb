

module InspectorMenuHandler

    def generate_menu()

        do_not_run_in_thread_menus = [ 'Click Element', 'Set Element', 'Focus', 'Set Key', 'Fire Event' ]

        @menu ||= (
          
            pop_menu = JPopupMenu.new

            menu.each do | menu_text, menu_lam |

                run_in_thread = !do_not_run_in_thread_menus.include?( menu_text )
                menu_item = JMenuItem.new( menu_text.to_s )
                menu_item.addActionListener( GenericActionListener.new( menu_lam, run_in_thread ) )
                pop_menu.add( menu_item )

            end

            pop_menu
        )
        @menu
    end

    def render_menu( component, x, y )
        generate_menu.show( component, x, y )
    end

end
