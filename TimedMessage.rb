require 'inline'
require 'test/unit'
require_relative 'contract'

module TimedMessage
  include Test::Unit::Assertions
  inline do |builder|
    builder.include '<unistd.h>'
    builder.include '<time.h>'
    builder.include '<string.h>'
    builder.include '<stdio.h>'
    builder.include '<stdlib.h>'
    builder.c 'void timed_delayed_message(int milliseconds){
      pid_t pid=fork();
      if(pid!=0) exit(0);
      struct timespec ts;
      ts.tv_sec=milliseconds/1000;
      ts.tv_nsec=(milliseconds%1000)*1000000;
      nanosleep(&ts,NULL);
    }'
  end

  def message(message)
    puts message
  end

  def timed_delayed_message_ruby(milliseconds)
    pre_timed_delay_message(milliseconds)
    parent_pid = Process.pid()
    milliseconds = milliseconds.to_i
    timed_delayed_message(milliseconds)
    post_timed_delay_message(parent_pid)

  end
end
