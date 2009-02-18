dir = File.dirname(__FILE__)
require File.expand_path("#{dir}/test_helper")
require File.expand_path("#{dir}/simple_sem_program")
require File.expand_path("#{dir}/arithmetic_node_classes")

Treetop.load File.expand_path("#{dir}/arithmetic")
Treetop.load File.expand_path("#{dir}/simple_sem")

class SimpleSemParserTest < Test::Unit::TestCase
  include ParserTestHelper
  
  def setup
    @parser = SimpleSemParser.new
    @ssp = SimpleSemProgram.new
  end
  
  def test_set_stmt_assign
    @ssp.data[0] = 2
    parse('set 1, D[0]').execute(@ssp)
    assert_equal [2, 2], @ssp.data
  end
  
  def test_set_stmt_write
    assert_nil parse('set write, 1').execute(@ssp)
  end
  
  def test_jump_stmt
    parse('jump 5').execute(@ssp)
    assert_equal 5, @ssp.pc
    
    @ssp.data[0] = 1
    parse('jump D[0]').execute(@ssp)
    assert_equal 1, @ssp.pc
  end
  
  def test_jumpt_stmt
    @ssp.data[0] = 2
    parse('jumpt 5, D[0]=D[0]').execute(@ssp)
    assert_equal 5, @ssp.pc
    
    @ssp.data[1] = 3
    parse('jumpt 6, D[0]=D[1]').execute(@ssp)
    assert_equal 5, @ssp.pc   # pc should have changed
  end
  
end