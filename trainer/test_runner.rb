

class TestRunner

  include BotFrameWorkModules
  include ConnectionInitializer
  include MonkeyBarsHelper
  include LoadSaveModule
  include ProfileInitializer


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

  def teardown()
      #do any teardown / cleanup code before killing trainer
  end

  def update()
      DashboardUiController.instance.get_model_var( :action_table_model ).update
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

  def add_action( action_klass, init_data={} )
      @trainer_actions << action_klass.new( init_data )
  end

  def insert( action_klass )
      return if !@selected_index
      @trainer_actions.insert( @selected_index, action_klass.new )
      @selected_index = nil
      update()
  end

  def delete()
      return if !@selected_index
      @trainer_actions.delete_at( @selected_index )
      @selected_index = nil
      update()
  end

  def init_test()
      init_vars()
      init_profile()
      reset_all()
      setup_connection()
  end

  def run_single_action()

      return if !selected_obj

      cloned = get_clone_vars( @test_thread ) if @test_thread

      @test_thread = Thread.new {
          begin

              clone_vars( cloned ) if cloned

              init_vars if !has_var_mediator?

              init_profile if !has_profile?

              Thread.current.init_uuid
              selected_obj.reset
              setup_connection()
              selected_obj.run

          rescue => err
              alert_pop_err( err, "Run Single Action Error: ")
          end

      }
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
          alert_pop_err( err, "Run Test Error: ")
      end

  end

end
