#require 'Kernel'

require 'getoptlong'

class ShellWrapper

	@arr=[]


	def initialize

	end

	def main
		while

			commands = get_command
			parse_command(commands)
			#create_child(commands)
			
			# parent waits for child to finish
			# child: change job
			# parent: reports results
		end
	end

	def create_child(commands)

		pid = fork {execute(commands)}
		@arr << pid
		waitpid(pid, Process::WHOHANG)

	end

	def get_command
		command = gets

	end

	def execute(commands)
		b=system("bash","-c", commands)
		puts b
	end

	def parse_command(commands)

		commands=commands.chomp
		case 
		when /\Acd /.match(commands)
			path = commands.split(/\Acd /)[1]
			Dir.chdir(path)

		else
			create_child(commands)
		end

	end

end

theone = ShellWrapper.new
theone.main