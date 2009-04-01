require 'rubygems'
require 'treetop'
dir = File.dirname(__FILE__)
require File.expand_path("#{dir}/arithmetic_node_classes")
Treetop.load File.expand_path("#{dir}/arithmetic")
Treetop.load File.expand_path("#{dir}/simple_sem")

class ProgramHalt < Exception
end

class SimpleSemProgram
  attr_reader :code
  attr_accessor :data, :pc
  
  # Create a SimpleSemProgram instance
  # Params:
  #   (String)filepath: path to SimpleSem source file.
  #   Optional because it's useful to use in tests without needing to load a file
  def initialize filepath=nil
    @code = Array.new
    if filepath
      IO.foreach(filepath) do |line|
        @code << line.split("//", 2)[0].strip # seperate the comment from the code
      end
    end
    
    @data = Array.new
    @pc = 0
  end
  
  def run
    @parser = SimpleSemParser.new
    
    @pc = 0
    loop do
      instruction = @code[@pc]  # fetch
      @pc += 1                  # increment
      begin
        @parser.parse(instruction).execute(self)  # decode and execute
      rescue ProgramHalt
        break
      end
    end
  end
  
  def inspect_data
    res = String.new
    @data.each_with_index {|loc, i| res += "#{i}: #{loc.last}\n" }
    res
  end
  
  def inspect_data_with_history
    res = String.new
    @data.each_with_index {|loc, i| res += "#{i}: #{loc.inspect}\n" }
    res
  end
end