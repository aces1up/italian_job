

class TrainerAction

	# handles rendering of trainer data
	# and running of the action obj attached to this trainer object

  extend DefaultTrainerData

  attr_reader :has_run, :status, :breakpoint, :info, :action, :data

	def initialize()

		@has_run      =   false
		@status       =   :idle
		@breakpoint   =   false
    @stop         =   false #<---- set to true when we get a stop signal

    #our log / info about this action
    @info         =   ""
		@log          =   ""                                             #<---- log of everything that happens with this action
    @action       =   self.class.to_s

		@data         =   GUIContainer.new( self.class.trainer_data )    #<---- data used to init our action object
		@action_obj   =   nil                                            #<---- the action object we are currently running

	end

  def reset()
      #clear out this action to get it ready to run again.
      @log  = ""
      @stop = false
  end

  def run()
      #1.  initialize normal trainer object with our @data
      #2.
  end

end
