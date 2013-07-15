

class TrainerAction

	# handles rendering of trainer data
	# and running of the action obj attached to this trainer object

  extend DefaultTrainerData
  include BotFrameWorkModules
  include TrainerActionGUIHelper

  attr_reader :has_run, :status, :breakpoint, :output, :action, :data

	def initialize( init_data={} )

		@has_run      =   false
		@status       =   :idle
		@breakpoint   =   false
    @stop         =   false    #<---- set to true when we get a stop signal

    #our log / info about this action
    @output       =   ""
		@log          =   ""                                             #<---- log of everything that happens with this action
    @action       =   self.class.to_s.gsub('Trainer','')

		@data         =   ActionGUIDataHelper.new( self.class.trainer_data, nil, init_data )    #<---- data used to init our action object
		@action_obj   =   nil                                            #<---- the action object we are currently running

    #our connection_options
    @connection_class   = nil
    @connection_options = {}

    update()
	end

  def set_global_connection_options( conn_klass, conn_options )
      @connection_class    = conn_klass
      @connection_options  = conn_options
  end

  def set_breakpoint()
      @breakpoint = true
      update()
  end

  def clear_breakpoint()
      @breakpoint = false
      update()
  end

  def to_disk()
      #generates a hash for this action_data to save to disk
      init_action_obj.to_disk
  end

  def import( data={} )
      #sets data on gui according to to data hash
      @data.import( data )
  end

  def set_action_status( status )
      @status = status ; update
  end

  def set_status_from_enviornment()
      set_action_status( self[:status] )
  end

  def save_trainer_data()
      @data.save
      @data.clear_focused
  end

  def reset()
      #clear out this action to get it ready to run again.
      @log      =  ""
      @stop     =  false
      @output   =  ""
      @has_run  =  false
      set_action_status( :idle )
  end

  def init_action_obj()

      init_data = @data.all_vars_to_load_data
      #add in our connection options initialized from the test_runner
      #object
      init_data[:connection_class]    = @connection_class
      init_data[:connection_options]  = @connection_options

      @action_obj = get_constant( @action ).new( init_data )
      @action_obj
  end

  def run()
      #1.  initialize normal trainer object with our @data

      if @breakpoint
          set_action_status( :breakpoint )
          return
      end

      begin
           set_action_status( :running )
           set_log_handler( self )
           
           init_action_obj()
           @action_obj.run

           info("#{@action} Finished Successfully! ")
           set_action_status( :success )

      rescue GeneralAppException => err

         err.report
         set_status_from_enviornment()
         #alert_pop_err( err, 'Rescue General Error' )
          
      rescue FatalAppError => err

         err.report
         set_status_from_enviornment()
         #alert_pop_err( err, 'Rescue Fatal Error' )

      rescue => err

          alert_pop_err( err, 'Fatal Trainer Action Run Error' )

      ensure
          @has_run = true
          clear_log_handler()
          update()
      end

  end

end
