#!/usr/bin/env ruby
dir = File.dirname(__FILE__)
require File.expand_path("#{dir}/simple_sem_program")

ssp = SimpleSemProgram.new(ARGV[0])
ssp.run

puts "\n" + ssp.data.inspect