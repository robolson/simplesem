module SimpleSem
  include Treetop::Runtime

  def root
    @root || :statement
  end

  include Arithmetic

  def _nt_statement
    start_index = index
    if node_cache[:statement].has_key?(index)
      cached = node_cache[:statement][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    r1 = _nt_set_stmt
    if r1
      r0 = r1
    else
      r2 = _nt_jump_stmt
      if r2
        r0 = r2
      else
        r3 = _nt_jumpt_stmt
        if r3
          r0 = r3
        else
          r4 = _nt_halt
          if r4
            r0 = r4
          else
            self.index = i0
            r0 = nil
          end
        end
      end
    end

    node_cache[:statement][start_index] = r0

    return r0
  end

  module Halt0
    def execute(env={})
      raise ProgramHalt
    end
  end

  def _nt_halt
    start_index = index
    if node_cache[:halt].has_key?(index)
      cached = node_cache[:halt][index]
      @index = cached.interval.end if cached
      return cached
    end

    if input.index('halt', index) == index
      r0 = (SyntaxNode).new(input, index...(index + 4))
      r0.extend(Halt0)
      @index += 4
    else
      terminal_parse_failure('halt')
      r0 = nil
    end

    node_cache[:halt][start_index] = r0

    return r0
  end

  def _nt_set_stmt
    start_index = index
    if node_cache[:set_stmt].has_key?(index)
      cached = node_cache[:set_stmt][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    r1 = _nt_set_stmt_assign
    if r1
      r0 = r1
    else
      r2 = _nt_set_stmt_write
      if r2
        r0 = r2
      else
        r3 = _nt_set_stmt_read
        if r3
          r0 = r3
        else
          self.index = i0
          r0 = nil
        end
      end
    end

    node_cache[:set_stmt][start_index] = r0

    return r0
  end

  module SetStmtAssign0
    def space
      elements[1]
    end

    def loc
      elements[2]
    end

    def comma
      elements[3]
    end

    def value
      elements[4]
    end
  end

  module SetStmtAssign1
    def execute(env)
      env.data[loc.eval(env)] = value.eval(env)
    end
  end

  def _nt_set_stmt_assign
    start_index = index
    if node_cache[:set_stmt_assign].has_key?(index)
      cached = node_cache[:set_stmt_assign][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index('set', index) == index
      r1 = (SyntaxNode).new(input, index...(index + 3))
      @index += 3
    else
      terminal_parse_failure('set')
      r1 = nil
    end
    s0 << r1
    if r1
      r2 = _nt_space
      s0 << r2
      if r2
        r3 = _nt_additive
        s0 << r3
        if r3
          r4 = _nt_comma
          s0 << r4
          if r4
            r5 = _nt_additive
            s0 << r5
          end
        end
      end
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(SetStmtAssign0)
      r0.extend(SetStmtAssign1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:set_stmt_assign][start_index] = r0

    return r0
  end

  module SetStmtWrite0
    def space
      elements[1]
    end

    def comma
      elements[3]
    end

    def expression
      elements[4]
    end
  end

  module SetStmtWrite1
    def execute(env)
      puts expression.eval(env)
    end
  end

  module SetStmtWrite2
  end

  module SetStmtWrite3
    def space
      elements[1]
    end

    def comma
      elements[3]
    end

    def string
      elements[5]
    end

  end

  module SetStmtWrite4
    def execute(env)
      puts string.text_value
    end
  end

  def _nt_set_stmt_write
    start_index = index
    if node_cache[:set_stmt_write].has_key?(index)
      cached = node_cache[:set_stmt_write][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    if input.index('set', index) == index
      r2 = (SyntaxNode).new(input, index...(index + 3))
      @index += 3
    else
      terminal_parse_failure('set')
      r2 = nil
    end
    s1 << r2
    if r2
      r3 = _nt_space
      s1 << r3
      if r3
        if input.index('write', index) == index
          r4 = (SyntaxNode).new(input, index...(index + 5))
          @index += 5
        else
          terminal_parse_failure('write')
          r4 = nil
        end
        s1 << r4
        if r4
          r5 = _nt_comma
          s1 << r5
          if r5
            r6 = _nt_expression
            s1 << r6
          end
        end
      end
    end
    if s1.last
      r1 = (SyntaxNode).new(input, i1...index, s1)
      r1.extend(SetStmtWrite0)
      r1.extend(SetStmtWrite1)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      i7, s7 = index, []
      if input.index('set', index) == index
        r8 = (SyntaxNode).new(input, index...(index + 3))
        @index += 3
      else
        terminal_parse_failure('set')
        r8 = nil
      end
      s7 << r8
      if r8
        r9 = _nt_space
        s7 << r9
        if r9
          if input.index('write', index) == index
            r10 = (SyntaxNode).new(input, index...(index + 5))
            @index += 5
          else
            terminal_parse_failure('write')
            r10 = nil
          end
          s7 << r10
          if r10
            r11 = _nt_comma
            s7 << r11
            if r11
              if input.index('"', index) == index
                r12 = (SyntaxNode).new(input, index...(index + 1))
                @index += 1
              else
                terminal_parse_failure('"')
                r12 = nil
              end
              s7 << r12
              if r12
                s13, i13 = [], index
                loop do
                  i14, s14 = index, []
                  i15 = index
                  if input.index('"', index) == index
                    r16 = (SyntaxNode).new(input, index...(index + 1))
                    @index += 1
                  else
                    terminal_parse_failure('"')
                    r16 = nil
                  end
                  if r16
                    r15 = nil
                  else
                    self.index = i15
                    r15 = SyntaxNode.new(input, index...index)
                  end
                  s14 << r15
                  if r15
                    if index < input_length
                      r17 = (SyntaxNode).new(input, index...(index + 1))
                      @index += 1
                    else
                      terminal_parse_failure("any character")
                      r17 = nil
                    end
                    s14 << r17
                  end
                  if s14.last
                    r14 = (SyntaxNode).new(input, i14...index, s14)
                    r14.extend(SetStmtWrite2)
                  else
                    self.index = i14
                    r14 = nil
                  end
                  if r14
                    s13 << r14
                  else
                    break
                  end
                end
                r13 = SyntaxNode.new(input, i13...index, s13)
                s7 << r13
                if r13
                  if input.index('"', index) == index
                    r18 = (SyntaxNode).new(input, index...(index + 1))
                    @index += 1
                  else
                    terminal_parse_failure('"')
                    r18 = nil
                  end
                  s7 << r18
                end
              end
            end
          end
        end
      end
      if s7.last
        r7 = (SyntaxNode).new(input, i7...index, s7)
        r7.extend(SetStmtWrite3)
        r7.extend(SetStmtWrite4)
      else
        self.index = i7
        r7 = nil
      end
      if r7
        r0 = r7
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:set_stmt_write][start_index] = r0

    return r0
  end

  module SetStmtRead0
    def space
      elements[1]
    end

    def loc
      elements[2]
    end

    def comma
      elements[3]
    end

  end

  module SetStmtRead1
    def execute(env)
      print "input: "
      env.data[loc.eval(env)] = $stdin.gets.strip.to_i
    end
  end

  def _nt_set_stmt_read
    start_index = index
    if node_cache[:set_stmt_read].has_key?(index)
      cached = node_cache[:set_stmt_read][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index('set', index) == index
      r1 = (SyntaxNode).new(input, index...(index + 3))
      @index += 3
    else
      terminal_parse_failure('set')
      r1 = nil
    end
    s0 << r1
    if r1
      r2 = _nt_space
      s0 << r2
      if r2
        r3 = _nt_additive
        s0 << r3
        if r3
          r4 = _nt_comma
          s0 << r4
          if r4
            if input.index('read', index) == index
              r5 = (SyntaxNode).new(input, index...(index + 4))
              @index += 4
            else
              terminal_parse_failure('read')
              r5 = nil
            end
            s0 << r5
          end
        end
      end
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(SetStmtRead0)
      r0.extend(SetStmtRead1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:set_stmt_read][start_index] = r0

    return r0
  end

  module JumpStmt0
    def space
      elements[1]
    end

    def loc
      elements[2]
    end
  end

  module JumpStmt1
    def execute(env)
      env.pc = loc.eval(env)
    end
  end

  def _nt_jump_stmt
    start_index = index
    if node_cache[:jump_stmt].has_key?(index)
      cached = node_cache[:jump_stmt][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index('jump', index) == index
      r1 = (SyntaxNode).new(input, index...(index + 4))
      @index += 4
    else
      terminal_parse_failure('jump')
      r1 = nil
    end
    s0 << r1
    if r1
      r2 = _nt_space
      s0 << r2
      if r2
        r3 = _nt_additive
        s0 << r3
      end
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(JumpStmt0)
      r0.extend(JumpStmt1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:jump_stmt][start_index] = r0

    return r0
  end

  module JumptStmt0
    def space
      elements[1]
    end

    def loc
      elements[2]
    end

    def comma
      elements[3]
    end

    def expression
      elements[4]
    end
  end

  module JumptStmt1
    def execute(env)
      if expression.eval(env)
        env.pc = loc.eval(env)
      end
    end
  end

  def _nt_jumpt_stmt
    start_index = index
    if node_cache[:jumpt_stmt].has_key?(index)
      cached = node_cache[:jumpt_stmt][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index('jumpt', index) == index
      r1 = (SyntaxNode).new(input, index...(index + 5))
      @index += 5
    else
      terminal_parse_failure('jumpt')
      r1 = nil
    end
    s0 << r1
    if r1
      r2 = _nt_space
      s0 << r2
      if r2
        r3 = _nt_additive
        s0 << r3
        if r3
          r4 = _nt_comma
          s0 << r4
          if r4
            r5 = _nt_expression
            s0 << r5
          end
        end
      end
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(JumptStmt0)
      r0.extend(JumptStmt1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:jumpt_stmt][start_index] = r0

    return r0
  end

  module Primary0
    def space
      elements[1]
    end

    def expression
      elements[2]
    end

    def space
      elements[3]
    end

  end

  module Primary1
    def eval(env={})
      expression.eval(env)
    end
  end

  def _nt_primary
    start_index = index
    if node_cache[:primary].has_key?(index)
      cached = node_cache[:primary][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    r1 = _nt_ip
    if r1
      r0 = r1
    else
      r2 = _nt_data_lookup
      if r2
        r0 = r2
      else
        r3 = _nt_number
        if r3
          r0 = r3
        else
          i4, s4 = index, []
          if input.index('(', index) == index
            r5 = (SyntaxNode).new(input, index...(index + 1))
            @index += 1
          else
            terminal_parse_failure('(')
            r5 = nil
          end
          s4 << r5
          if r5
            r6 = _nt_space
            s4 << r6
            if r6
              r7 = _nt_expression
              s4 << r7
              if r7
                r8 = _nt_space
                s4 << r8
                if r8
                  if input.index(')', index) == index
                    r9 = (SyntaxNode).new(input, index...(index + 1))
                    @index += 1
                  else
                    terminal_parse_failure(')')
                    r9 = nil
                  end
                  s4 << r9
                end
              end
            end
          end
          if s4.last
            r4 = (SyntaxNode).new(input, i4...index, s4)
            r4.extend(Primary0)
            r4.extend(Primary1)
          else
            self.index = i4
            r4 = nil
          end
          if r4
            r0 = r4
          else
            self.index = i0
            r0 = nil
          end
        end
      end
    end

    node_cache[:primary][start_index] = r0

    return r0
  end

  module DataLookup0
    def expr
      elements[1]
    end

  end

  module DataLookup1
    def eval(env)
      env.data[expr.eval(env)]
    end
  end

  def _nt_data_lookup
    start_index = index
    if node_cache[:data_lookup].has_key?(index)
      cached = node_cache[:data_lookup][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index('D[', index) == index
      r1 = (SyntaxNode).new(input, index...(index + 2))
      @index += 2
    else
      terminal_parse_failure('D[')
      r1 = nil
    end
    s0 << r1
    if r1
      r2 = _nt_additive
      s0 << r2
      if r2
        if input.index(']', index) == index
          r3 = (SyntaxNode).new(input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure(']')
          r3 = nil
        end
        s0 << r3
      end
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(DataLookup0)
      r0.extend(DataLookup1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:data_lookup][start_index] = r0

    return r0
  end

  module Ip0
    def eval(env)
      env.pc
    end
  end

  def _nt_ip
    start_index = index
    if node_cache[:ip].has_key?(index)
      cached = node_cache[:ip][index]
      @index = cached.interval.end if cached
      return cached
    end

    if input.index('ip', index) == index
      r0 = (SyntaxNode).new(input, index...(index + 2))
      r0.extend(Ip0)
      @index += 2
    else
      terminal_parse_failure('ip')
      r0 = nil
    end

    node_cache[:ip][start_index] = r0

    return r0
  end

  module Comma0
    def space
      elements[0]
    end

    def space
      elements[2]
    end
  end

  def _nt_comma
    start_index = index
    if node_cache[:comma].has_key?(index)
      cached = node_cache[:comma][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_space
    s0 << r1
    if r1
      if input.index(',', index) == index
        r2 = (SyntaxNode).new(input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure(',')
        r2 = nil
      end
      s0 << r2
      if r2
        r3 = _nt_space
        s0 << r3
      end
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(Comma0)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:comma][start_index] = r0

    return r0
  end

end

class SimpleSemParser < Treetop::Runtime::CompiledParser
  include SimpleSem
end
