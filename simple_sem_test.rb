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
    @ssp.data[0] = 1
  end
  
  def test_set_stmt_assign
    parse('set 1, D[0]').execute(@ssp)
    assert_equal [1, 1], @ssp.data
  end
  
  def test_set_stmt_write
    assert_nil parse('set write, 1').execute(@ssp)
  end
  
  def test_jump_stmt
    parse('jump 5').execute(@ssp)
    assert_equal 5, @ssp.pc
  end
  
  def test_jump_to_data_loc
    parse('jump D[0]').execute(@ssp)
    assert_equal 1, @ssp.pc
  end
  
  def test_jumpt_stmt_true
    @ssp.data[0] = 1
    parse('jumpt 5, D[0]=D[0]').execute(@ssp)
    assert_equal 5, @ssp.pc
  end
    
  def test_jumpt_stmt_false
    @ssp.data[0] = 1
    parse('jumpt 5, D[0]=2').execute(@ssp)
    assert_equal 0, @ssp.pc   # pc should not have changed
  end
  
  def test_comparisons
    parse('jumpt 5, D[0] > 0').execute(@ssp)
    assert_equal 5, @ssp.pc    
  end
  
end