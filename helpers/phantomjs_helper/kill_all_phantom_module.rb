

module KillAllPhantom

    include HardwareHelper

    def kill_phantom_js()
        begin
           if defined?( PhantomJSEXE )
              process_name = File.basename( PhantomJSEXE )
              kill_process( process_name, true )
           else
              raise ConnectionError, "Cannot Hard Kill EasyRider Connection!  No PhantomJSEXE const defined!"
           end
        rescue => err
            alert_pop_err( err, 'EasyRider Hard Kill Error: ')
        end
    end
end
