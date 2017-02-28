require_relative 'FileWatcher.rb'
include FileWatcher
my_command=gets
creation(5000,["test_created.dummy"]){eval(my_command)}
