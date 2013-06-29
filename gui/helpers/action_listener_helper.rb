

class GenericActionListener

    include ActionListener

    def initialize(action_lambda, run_in_thread=true, *args)

        @action_lambda = action_lambda
        @args          = args
        @run_in_thread = run_in_thread

        super()
    end

    def do_call()
        begin
            @action_lambda.call(*@args)
        rescue => err
            alert_pop_err( err, 'Action Listener Call Error: ')
        end
    end

    def actionPerformed(event)
        @run_in_thread ? Thread.new{ do_call } : do_call
    end


end

