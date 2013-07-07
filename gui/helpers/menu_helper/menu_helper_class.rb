

class MenuHelper

    def initialize( menu_options={})
        # menu options is a hash with
        # key being menu name and the hash being
        # options of the following
        #    :lam_block        #<--- the lambda to run
        #    :run_in_thread    #<--- true or false if we want to run lam in thread
                               #<--- default is true
        @menu_options = menu_options
    end

    def generate_menu()
        @menu ||= (

            pop_menu = JPopupMenu.new

            @menu_options.each do | menu_text, menu_options |

                run_in_thread = menu_options[:run_in_thread].nil? ? true : menu_options[:run_in_thread]
                menu_item = JMenuItem.new( menu_text.to_s )
                menu_item.addActionListener( GenericActionListener.new( menu_options[:lam_block], run_in_thread ) )
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
