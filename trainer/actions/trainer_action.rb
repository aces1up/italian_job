

class TrainerAction

	# handles rendering of trainer data
	# and running of the action obj attached to this trainer object

  extend DefaultTrainerData
  include BotFrameWorkModules

  attr_reader :has_run, :status, :breakpoint, :info, :action, :data

	def initialize()

		@has_run      =   false
		@status       =   :idle
		@breakpoint   =   false
    @stop         =   false #<---- set to true when we get a stop signal

    #our log / info about this action
    @info         =   ""
		@log          =   ""                                             #<---- log of everything that happens with this action
    @action       =   self.class.to_s.gsub('Trainer','')

		@data         =   GUIContainer.new( self.class.trainer_data )    #<---- data used to init our action object
		@action_obj   =   nil                                            #<---- the action object we are currently running

    update()
	end

  #gui handling stuff

  def update()
      DashboardUiController.instance.get_model_var( :action_table_model ).update
  end

  def set_status( status )
      @status = status ; update
  end

  def render_trainer_data()
      begin
          ActionDataUiController.instance.open
          ActionDataUiController.instance.set_action_label
          @data.render
      rescue => err
          alert_pop_err( err, "Render Data Error: " )
      end
  end

  def save_trainer_data()
      @data.save
  end

  def reset()
      #clear out this action to get it ready to run again.
      @log  = ""
      @stop = false
      set_status( :idle )
  end

  def init_action_obj()
      @action_obj = get_constant( @action ).new( @data.all_vars )
  end

  def run()
      #1.  initialize normal trainer object with our @data
      set_status( :running )

      begin
           init_action_obj()
           @action_obj.run

           set_status( :success)

      rescue GeneralAppException => err
          alert_pop_err( err, 'General App Error' )

      rescue FatalAppError => err

          alert_pop_err( err, 'Fatal App Error' )

      rescue => err

          alert_pop_err( err, 'Super Fatal App Error' )

      ensure
          @has_run = true
          update()
      end

  end

end
