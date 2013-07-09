

class FileChooserHelper

    attr_reader :file

    def initialize( lam_block=nil, start_directory=$working_directory, save=false, choose_directory=false )

        @lam              = lam_block
        @save             = save
        @choose_directory = choose_directory     #<--- set to true only to allow selection of Directory
        @start_directory  = start_directory      #<--- start directory to show in file chooser
        @file             = nil

        open_file_chooser
    end

    def run_block()
        Thread.new { 
          begin
            @lam.call( @file )
          rescue => err
            puts "File Chooser Error: #{err.message}\n#{err.backtrace}"
          end
        }
    end

    def open_file_chooser
        show_method = @save ? :showSaveDialog : :showOpenDialog
        filechooser = JFileChooser.new( @start_directory )
        filechooser.setFileSelectionMode( JFileChooser::DIRECTORIES_ONLY ) if @choose_directory
        result = filechooser.send(show_method, nil)
        #1 == cancel
        #0 == clicked
        return if result == 1

        @file = filechooser.getSelectedFile().toString


        @lam ? run_block : @file
    end


end
