
java_import javax.swing.JOptionPane

def get_info_dialog( title, dialog_text )
    text = javax.swing.JOptionPane.showInputDialog(
        nil, dialog_text, title, JOptionPane::PLAIN_MESSAGE, nil, nil, nil)
        #check to see if cancel button was pressed
    return nil if !text
    text
end

def get_yes_no(title, dialog_text)
    result = JOptionPane.showConfirmDialog( nil, dialog_text, title, JOptionPane::YES_NO_OPTION )
    result == 0 ? true : false
end
