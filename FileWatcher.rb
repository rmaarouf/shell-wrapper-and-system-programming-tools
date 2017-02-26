require_relative 'TimedMessage'
module FileWatcher
  include TimedMessage
  def creation(duration, list_filenames)
    timed_delayed_message(milliseconds)
  end

  def alter(duration, list_filenames)
    timed_delayed_message(ARGV[0].to_i)
  end

  def destroy(duration, list_filenames)
    timed_delayed_message(ARGV[0].to_i)
  end


end
