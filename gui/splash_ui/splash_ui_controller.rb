class SplashUiController < ApplicationController
  set_model 'SplashUiModel'
  set_view 'SplashUiView'
  set_close_action :close


  def load()
      model.init_progress
  end

  def update_msg( msg_output, log_level=nil, thread=nil )

      #receives log messages from our log handler
      #in the bot framework gem
      if ( log_level and log_level == :fatal )
          alert_pop( msg_output )
      else
          model.progress.update_progress( msg_output )
      end

  end

end
