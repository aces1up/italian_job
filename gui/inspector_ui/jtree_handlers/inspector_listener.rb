

class JtreeMouseListener < MouseAdapter

    def initialize(jtree)
        @jtree = jtree
        super()
    end

    def mouseClicked(e)
        if ( SwingUtilities.isRightMouseButton(e) )
          row = @jtree.getClosestRowForLocation( e.getX(), e.getY() )
          @jtree.setSelectionRow(row)

          selected_node = @jtree.getLastSelectedPathComponent
          selected_node.render_menu( e.getComponent(), e.getX(), e.getY() )

          #@context_menu.pop_up_menu.show( e.getComponent(), e.getX(), e.getY() )
        end
    end
end
