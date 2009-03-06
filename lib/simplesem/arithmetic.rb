module Arithmetic
  include Treetop::Runtime

  def root
    @root || :expression
  end

  def _nt_expression
    start_index = index
    if node_cache[:expression].has_key?(index)
      cached = node_cache[:expression][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    r1 = _nt_comparative
    if r1
      r0 = r1
    else
      r2 = _nt_additive
      if r2
        r0 = r2
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:expression][start_index] = r0

    return r0
  end

  module Comparative0
    def operand_1
      elements[0]
    end

    def space
      elements[1]
    end

    def operator
      elements[2]
    end

    def space
      elements[3]
    end

    def operand_2
      elements[4]
    end
  end

  def _nt_comparative
    start_index = index
    if node_cache[:comparative].has_key?(index)
      cached = node_cache[:comparative][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_additive
    s0 << r1
    if r1
      r2 = _nt_space
      s0 << r2
      if r2
        r3 = _nt_comparison_op
        s0 << r3
        if r3
          r4 = _nt_space
          s0 << r4
          if r4
            r5 = _nt_additive
            s0 << r5
          end
        end
      end
    end
    if s0.last
      r0 = (BinaryOperation).new(input, i0...index, s0)
      r0.extend(Comparative0)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:comparative][start_index] = r0

    return r0
  end

  module ComparisonOp0
    def apply(a, b)
      a >= b
    end
  end

  module ComparisonOp1
    def apply(a, b)
      a <= b
    end
  end

  module ComparisonOp2
    def apply(a, b)
      a > b
    end
  end

  module ComparisonOp3
    def apply(a, b)
      a < b
    end
  end

  module ComparisonOp4
    def apply(a, b)
      a != b
    end
  end

  module ComparisonOp5
    def apply(a, b)
      a == b
    end
  end

  def _nt_comparison_op
    start_index = index
    if node_cache[:comparison_op].has_key?(index)
      cached = node_cache[:comparison_op][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    if input.index('>=', index) == index
      r1 = (SyntaxNode).new(input, index...(index + 2))
      r1.extend(ComparisonOp0)
      @index += 2
    else
      terminal_parse_failure('>=')
      r1 = nil
    end
    if r1
      r0 = r1
    else
      if input.index('<=', index) == index
        r2 = (SyntaxNode).new(input, index...(index + 2))
        r2.extend(ComparisonOp1)
        @index += 2
      else
        terminal_parse_failure('<=')
        r2 = nil
      end
      if r2
        r0 = r2
      else
        if input.index('>', index) == index
          r3 = (SyntaxNode).new(input, index...(index + 1))
          r3.extend(ComparisonOp2)
          @index += 1
        else
          terminal_parse_failure('>')
          r3 = nil
        end
        if r3
          r0 = r3
        else
          if input.index('<', index) == index
            r4 = (SyntaxNode).new(input, index...(index + 1))
            r4.extend(ComparisonOp3)
            @index += 1
          else
            terminal_parse_failure('<')
            r4 = nil
          end
          if r4
            r0 = r4
          else
            if input.index('!=', index) == index
              r5 = (SyntaxNode).new(input, index...(index + 2))
              r5.extend(ComparisonOp4)
              @index += 2
            else
              terminal_parse_failure('!=')
              r5 = nil
            end
            if r5
              r0 = r5
            else
              if input.index('=', index) == index
                r6 = (SyntaxNode).new(input, index...(index + 1))
                r6.extend(ComparisonOp5)
                @index += 1
              else
                terminal_parse_failure('=')
                r6 = nil
              end
              if r6
                r0 = r6
              else
                self.index = i0
                r0 = nil
              end
            end
          end
        end
      end
    end

    node_cache[:comparison_op][start_index] = r0

    return r0
  end

  module Additive0
    def operand_1
      elements[0]
    end

    def space
      elements[1]
    end

    def operator
      elements[2]
    end

    def space
      elements[3]
    end

    def operand_2
      elements[4]
    end
  end

  def _nt_additive
    start_index = index
    if node_cache[:additive].has_key?(index)
      cached = node_cache[:additive][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    r2 = _nt_multitive
    s1 << r2
    if r2
      r3 = _nt_space
      s1 << r3
      if r3
        r4 = _nt_additive_op
        s1 << r4
        if r4
          r5 = _nt_space
          s1 << r5
          if r5
            r6 = _nt_additive
            s1 << r6
          end
        end
      end
    end
    if s1.last
      r1 = (BinaryOperation).new(input, i1...index, s1)
      r1.extend(Additive0)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      r7 = _nt_multitive
      if r7
        r0 = r7
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:additive][start_index] = r0

    return r0
  end

  module AdditiveOp0
    def apply(a, b)
      a + b
    end
  end

  module AdditiveOp1
    def apply(a, b)
      a - b
    end
  end

  def _nt_additive_op
    start_index = index
    if node_cache[:additive_op].has_key?(index)
      cached = node_cache[:additive_op][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    if input.index('+', index) == index
      r1 = (SyntaxNode).new(input, index...(index + 1))
      r1.extend(AdditiveOp0)
      @index += 1
    else
      terminal_parse_failure('+')
      r1 = nil
    end
    if r1
      r0 = r1
    else
      if input.index('-', index) == index
        r2 = (SyntaxNode).new(input, index...(index + 1))
        r2.extend(AdditiveOp1)
        @index += 1
      else
        terminal_parse_failure('-')
        r2 = nil
      end
      if r2
        r0 = r2
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:additive_op][start_index] = r0

    return r0
  end

  module Multitive0
    def operand_1
      elements[0]
    end

    def space
      elements[1]
    end

    def operator
      elements[2]
    end

    def space
      elements[3]
    end

    def operand_2
      elements[4]
    end
  end

  def _nt_multitive
    start_index = index
    if node_cache[:multitive].has_key?(index)
      cached = node_cache[:multitive][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    r2 = _nt_primary
    s1 << r2
    if r2
      r3 = _nt_space
      s1 << r3
      if r3
        r4 = _nt_multitive_op
        s1 << r4
        if r4
          r5 = _nt_space
          s1 << r5
          if r5
            r6 = _nt_multitive
            s1 << r6
          end
        end
      end
    end
    if s1.last
      r1 = (BinaryOperation).new(input, i1...index, s1)
      r1.extend(Multitive0)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      r7 = _nt_primary
      if r7
        r0 = r7
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:multitive][start_index] = r0

    return r0
  end

  module MultitiveOp0
    def apply(a, b)
      a * b
    end
  end

  module MultitiveOp1
    def apply(a, b)
      a / b
    end
  end

  def _nt_multitive_op
    start_index = index
    if node_cache[:multitive_op].has_key?(index)
      cached = node_cache[:multitive_op][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    if input.index('*', index) == index
      r1 = (SyntaxNode).new(input, index...(index + 1))
      r1.extend(MultitiveOp0)
      @index += 1
    else
      terminal_parse_failure('*')
      r1 = nil
    end
    if r1
      r0 = r1
    else
      if input.index('/', index) == index
        r2 = (SyntaxNode).new(input, index...(index + 1))
        r2.extend(MultitiveOp1)
        @index += 1
      else
        terminal_parse_failure('/')
        r2 = nil
      end
      if r2
        r0 = r2
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:multitive_op][start_index] = r0

    return r0
  end

  module Number0
  end

  module Number1
    def eval(env={})
      text_value.to_i
    end
  end

  def _nt_number
    start_index = index
    if node_cache[:number].has_key?(index)
      cached = node_cache[:number][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    if input.index('-', index) == index
      r3 = (SyntaxNode).new(input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure('-')
      r3 = nil
    end
    if r3
      r2 = r3
    else
      r2 = SyntaxNode.new(input, index...index)
    end
    s1 << r2
    if r2
      if input.index(Regexp.new('[1-9]'), index) == index
        r4 = (SyntaxNode).new(input, index...(index + 1))
        @index += 1
      else
        r4 = nil
      end
      s1 << r4
      if r4
        s5, i5 = [], index
        loop do
          if input.index(Regexp.new('[0-9]'), index) == index
            r6 = (SyntaxNode).new(input, index...(index + 1))
            @index += 1
          else
            r6 = nil
          end
          if r6
            s5 << r6
          else
            break
          end
        end
        r5 = SyntaxNode.new(input, i5...index, s5)
        s1 << r5
      end
    end
    if s1.last
      r1 = (SyntaxNode).new(input, i1...index, s1)
      r1.extend(Number0)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
      r0.extend(Number1)
    else
      if input.index('0', index) == index
        r7 = (SyntaxNode).new(input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure('0')
        r7 = nil
      end
      if r7
        r0 = r7
        r0.extend(Number1)
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:number][start_index] = r0

    return r0
  end

  def _nt_space
    start_index = index
    if node_cache[:space].has_key?(index)
      cached = node_cache[:space][index]
      @index = cached.interval.end if cached
      return cached
    end

    s0, i0 = [], index
    loop do
      if input.index(' ', index) == index
        r1 = (SyntaxNode).new(input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure(' ')
        r1 = nil
      end
      if r1
        s0 << r1
      else
        break
      end
    end
    r0 = SyntaxNode.new(input, i0...index, s0)

    node_cache[:space][start_index] = r0

    return r0
  end

end

class ArithmeticParser < Treetop::Runtime::CompiledParser
  include Arithmetic
end
