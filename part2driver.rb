require_relative 'TimedMessage'
include TimedMessage
timed_delayed_message(ARGV[0].to_i)
message(ARGV[1])
