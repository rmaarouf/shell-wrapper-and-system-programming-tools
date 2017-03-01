
def shell_invariant()
	assert(self.respond_to?(:get_errno), 'not a valid shell_wrapper')
end

def post_invariant()
	assert_equal self.get_errno,:NOERROR, 'failed shell_intialization'
	shell_invariant
end

def pre_create_manage_child(commands)
	assert(commands.respond_to?(:chomp), 'command was not a string')
	shell_invariant
end

def post_create_manage_child()
	assert(self.get_errno.respond_to?(:to_s), 'failed to get errno' )
	shell_invariant
end

def pre_execute(commands)
	assert(commands.respond_to?(:chomp), 'command was not a string')
	shell_invariant
end

def post_execute(myval)
	assert(myval.respond_to?(:round), 'recieved an invalid errno')
	shell_invariant
end

def pre_convert_errno(myval)
	assert(myval.respond_to?(:round), 'recieved an invalid errno')
	shell_invariant
end

def post_convert_errno(new_errno)
	assert(new_errno.respond_to?(:to_s), 'failed to get errno' )
	shell_invariant
end

def pre_parse_command(commands)
	assert(commands.respond_to?(:chomp), 'command was not a string')
	shell_invariant
end

def post_parse_command()
	shell_invariant
end

def pre_timed_delay_message(milliseconds)
	assert(milliseconds =~ /^\d+$/ ? true:false, 'invalid delay time')
end

def post_timed_delay_message(parent_pid)
	assert(Process.pid() != parent_pid, 'parent process still alive' )
end