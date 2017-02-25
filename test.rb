require_relative 'TimedMessage'
length= ARGV[0].to_i;
# puts ARGV[1];
TimedMessage.timed_delayed_message(length,ARGV[1])
# fork{
#   sleep(5)
#   puts "fucking heated"
# }
# puts "done"
