

class TestRunner

  include BotFrameWorkModules
  include ConnectionInitializer
  include MonkeyBarsHelper

	# this should run in its own thread just like
	# a normal function would

	# this is used to init and run the test suite
	# with all the currently loaded trainer actions

  attr_reader :trainer_actions, :test_thread

	def initialize()

		  @trainer_actions = []     #<--- all our trainer action objects
      @selected_index  = nil

      @test_thread     = nil    #<--- the test thread that last executed this test.

	end

  def start_test()
      @test_thread = Thread.new { run_test }
  end

  def reset_all()
      #resets all actions currently loaded
      @trainer_actions.each do |trainer_action| trainer_action.reset end
  end

  def execute_test?()
      return false if @trainer_actions.empty?
      true
  end

  def selected_obj()
      return nil if @trainer_actions.empty?
      @trainer_actions[ @selected_index ]
  end

  def set_selected( index )
      @selected_index = index
  end

  def add( action_klass )
      @trainer_actions << action_klass.new
  end

  def init_test()
      init_vars()
      reset_all()
      setup_connection()
  end

  def run_test()
      #create a new thread and record it for later purposes of retrieving
      #the thread vars from it.
      
      begin

          return if !execute_test?
        
          init_test()

          @trainer_actions.each do | trainer_action |
              trainer_action.run()
          end

      rescue => err
          alert_pop_err(err, "Run Test Error: ")
      end

  end

end
