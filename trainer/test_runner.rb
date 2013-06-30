

class TestRunner

  include BotFrameWorkModules

	# this should run in its own thread just like
	# a normal function would

	# this is used to init and run the test suite
	# with all the currently loaded trainer actions

  attr_reader :trainer_actions

	def initialize()

		  @trainer_actions = []     #<--- all our trainer action objects
      @test_thread     = nil    #<--- the test thread that last executed this test.

	end

  def start_test()
      @test_thread = Thread.new { run_test }
  end

  def run_test()
      #create a new thread and record it for later purposes of retrieving
      #the thread vars from it.

      init_vars()
      begin
          puts "running test: #{Thread.current.__id__}"
      rescue => err
          alert_pop_err(err, "Run Test Error: ")
      end

  end

end
