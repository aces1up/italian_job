class SplashUiModel

    attr_accessor :progress

    def initialize()
        @progress = nil
    end

    def init_progress()
        @progress ||= (
            gui_progress = SplashUiController.instance.get_gui_handle( :startup_progress )
            prog_bar = ProgressBarHelper.new( gui_progress )
            prog_bar.init_progress_bar( 0, 5 )
            prog_bar.update_progress( 'LinkWheel Bandit Trainer Starting...' )
            prog_bar
        )

    end

end
