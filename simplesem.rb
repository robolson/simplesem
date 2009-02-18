dir = File.dirname(__FILE__)
require File.expand_path("#{dir}/simple_sem_program")

# SimpleSemProgram.new(ARGV[0])
ssp = SimpleSemProgram.new("whileloop.c1.txt")
ssp.run
ssp.inspect_data