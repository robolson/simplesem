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
    assert_nil parse('set write, "hello world!"').execute(@ssp)
  end
  
  def test_jump_stmt
    parse('jump 5').execute(@ssp)
    assert_equal 5, @ssp.pc
  end
  
  def test_set_to_data_loc
    parse('set D[0], 2').execute(@ssp)
    assert_equal 2, @ssp.data[1]
  end
  
  def test_complex_expr
    @ssp.data[1] = 2
    parse('set 2, D[0]+D[1]*2').execute(@ssp)
    assert_equal 5, @ssp.data[2]
  end
  
  def test_parenthesis
    @ssp.data[1] = 2
    parse('set 2, (D[0]+D[1])*2').execute(@ssp)
    assert_equal 6, @ssp.data[2]
  end
  
  def test_set_increment_instr
    parse('set 0, D[0]+1').execute(@ssp)
    assert_equal 2, @ssp.data[0]
  end
  
  def test_nested_data_lookup
    @ssp.data[0] = 0
    @ssp.data[1] = 1
    parse('set 2, D[D[0]+1]').execute(@ssp)
    assert_equal 1, @ssp.data[2]
  end
  
  def test_instruction_pointer
    # run two dummy instructions, manually incrementing the program counter
    @ssp.pc = 1
    parse('set 0, 0').execute(@ssp)
    @ssp.pc = 2
    parse('set 0, ip').execute(@ssp)
    assert_equal 2, @ssp.data[0]  # check that the parser was able to read the ip correctly
  end
  
  def test_jump_to_data_loc
    @ssp.data[0] = 2
    parse('jump D[0]').execute(@ssp)
    assert_equal 2, @ssp.pc
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
  
  def test_less_than_comparison
    # test a jumpt that returns false
    parse('jumpt 5, D[0] < 0').execute(@ssp)
    assert_not_equal 5, @ssp.pc    
    
    parse('jumpt 5, D[0] < 2').execute(@ssp)
    assert_equal 5, @ssp.pc
  end
  
  def test_greater_than_comparison
    parse('jumpt 5, D[0] > 0').execute(@ssp)
    assert_equal 5, @ssp.pc    
  end
  
  def test_greater_than_or_eql_comparison
    parse('jumpt 5, 1 >= D[0]').execute(@ssp)
    assert_equal 5, @ssp.pc    
  end
  
  def test_less_than_or_eql_comparison
    parse('jumpt 5, 0 <= D[0]').execute(@ssp)
    assert_equal 5, @ssp.pc    
  end
  
  def test_negative_number
    parse('set 0, -1').execute(@ssp)
    assert_equal -1, @ssp.data[0]
  end
  
  def test_halt
    assert_raise ProgramHalt do
      parse('halt').execute(@ssp)
    end
  end
end