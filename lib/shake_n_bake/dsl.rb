# DSL for Shake n Bake
class ShakeNBake::DSL
  include Singleton

  # Setup Method for registering instance vars
  def setup(&block)
    self.instance_eval(&block) if block_given? 
  end

  # Shake ping the queue or data your watching
  def shake(&block)
    @shake_proc = block if block_given?
  end

  # Bake when result exec block
  def bake(&block)
    @bake_proc = block if block_given?
  end

  # Start your engines!
  def run
    register_signal_handlers
    loop do
      break if shutdown?
      result = self.instance_eval &@shake_proc
      self.instance_exec(result, &@bake_proc) if result
      sleep INTERVAL || 2
    end
  end

private
  # FROM Resque::Worker

  # Registers the various signal handlers a worker responds to.
  #
  # TERM: Shutdown immediately, stop processing jobs.
  #  INT: Shutdown immediately, stop processing jobs.
  # QUIT: Shutdown after the current job has finished processing.
  def register_signal_handlers
    trap('TERM') { shutdown!  }
    trap('INT')  { shutdown!  }
    begin
      trap('QUIT') { shutdown   }
    rescue ArgumentError
      warn "Signals QUIT, USR1, USR2, and/or CONT not supported."
    end
  end

  # Schedule this worker for shutdown. Will finish processing the
  # current job.
  def shutdown
    puts 'Exiting...'
    @shutdown = true
  end

  # Shutdown immediately.
  def shutdown!
    shutdown
  end

  # Should this worker shutdown as soon as current job is finished?
  def shutdown?
    @shutdown
  end

end