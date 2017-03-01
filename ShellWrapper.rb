require_relative 'contract'
require 'test/unit'

class ShellWrapper
	include Test::Unit::Assertions

	def initialize
		@arr=Array.new
		@errno_state=:NOERROR
		post_invariant
	end

	def main
		print "\\>"
		while
			commands = get_command
			parse_command(commands)
			print get_errno_message+"   \\>"
		end
	end

	def create_manage_child(commands)
		pre_create_manage_child(commands)
		read,write=IO.pipe

		pid = fork {
			proc{
				# $SAFE=4
				read.close
				value=execute(commands)
				Marshal.dump(value,write)
				exit!(0)
			}.call
		}
		Process.wait
		write.close
		myval=read.read
		raise "child is empty" if myval.empty?
		myval=Marshal.load(myval)
		set_errno(convert_errno(myval))
		@arr << pid
		post_create_manage_child
	end

	def convert_errno(myval)
		pre_convert_errno(myval)
		new_errno = Errno.constants.select{|x| eval("Errno::#{x}::Errno")==myval}[0]
		post_convert_errno(new_errno)
		return new_errno
	end

	def set_errno(errno_val)
		@errno_state=errno_val
	end

	def get_errno
		@errno_state
	end

	def get_errno_message
		eval("Errno::#{@errno_state}.new.message")
	end
	def get_command
		command = gets

	end

	def execute(commands)
		pre_execute(commands)

		myval=system("bash","-c", commands) #+blah
		myval=$?.exitstatus

		post_execute(myval)
		return myval

	end

	def parse_command(commands)
		pre_parse_command(commands)
		commands=commands.chomp
		case
		when /\Acd /.match(commands)
			begin
				path = commands.split(/\Acd /)[1]
				Dir.chdir(path)
			rescue
				puts "No such directory: " + path
				set_errno(:EPERM)
				return
			end
		when /\Aexit$/.match(commands)
			exit
		else
			create_manage_child(commands)
		end

		post_parse_command
	end
end

theone = ShellWrapper.new
theone.main
