require 'test/unit'
require 'rubygems'
require 'treetop'

module ParserTestHelper
  def assert_evals_to_self(input)
    assert_evals_to(input, input)
  end
  
  def parse(input)
    result = @parser.parse(input)
    unless result
      puts @parser.terminal_failures.join("\n")
    end
    assert !result.nil?
    result
  end
end

class InternalPuts
  attr_reader :out
  
  def self.capture 
    $stdout = instance = new
    yield
    $stdout = STDOUT
    return instance.out
  end
  
  def initialize
    @out = String.new
  end
  
  def write(str) 
    @out << str
  end 
end