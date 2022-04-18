# typed: true
require "test_helper"
require "corduroy/stack"

# Tests for Stack
class TestStack < Minitest::Test
  extend T::Sig

  def setup
    @stack = Corduroy::Stack.new(max_size: 10)
  end

  def test_stack
    (1..10).each do |n|
      @stack.push(n)
    end
    assert_raises(Corduroy::Stack::Overflow) { @stack.push(11) }
    10.times { @stack.pop }
    assert_raises(Corduroy::Stack::Underflow) { @stack.pop }
  end

  def test_reverse_a_word
    word = "trap"
    word.each_char do |char|
      @stack.push(char)
    end
    reversed = ""
    until @stack.empty?
      reversed += @stack.pop
    end
    assert_equal "part", reversed
  end

  # Validate a string delimited with brackets is correct
  # See Lafore's example, p.128 of DS&A in Java
  class BracketChecker
    OPEN_BRACKETS = ["{", "[", "("].freeze
    CLOSED_BRACKETS = ["}", "]", ")"].freeze

    class InvalidDelimiterError < StandardError; end

    def initialize(string:)
      @string = string
      @stack = Corduroy::Stack.new(max_size: @string.length)
    end

    def validate!
      @string.each_char.with_index(0) do |s, idx|
        @stack.push(s) if OPEN_BRACKETS.include?(s)
        if CLOSED_BRACKETS.include?(s)
          if !@stack.empty?
            top = @stack.pop
            if (s == "}" && top != "{") || (s == "]" && top != "[") || (s == ")" && top != "(")
              raise InvalidDelimiterError, "Invalid delimiter => #{s} at index #{idx}"
            end
          else
            raise InvalidDelimiterError, "Brackets ended prematurely => #{s} at index #{idx}"
          end
        end
      end
      true
    end
  end

  def test_bracket_checker
    checker = BracketChecker.new(string: "a{b(c]d}e")
    assert_raises(BracketChecker::InvalidDelimiterError) { checker.validate! }

    checker = BracketChecker.new(string: "a{l(l[g]o)o}d!")
    assert checker.validate!

    checker = BracketChecker.new(string: "()))")
    assert_raises(BracketChecker::InvalidDelimiterError) { checker.validate! }
  end

  # Stacks can be useful for solving a problem
  # iteratively instead of recursively
  def stack_fibonacci(fib_n)
    # Fibonacci series:
    # 0, 1, 1, 2, 3, 5, 8, 13, 21, 34
    stack = Corduroy::Stack.new(max_size: 2)
    stack.push(0) # first item in the series
    stack.push(1) # second item in the series
    num = T.let(0, T.untyped)
    (fib_n - stack.max_size).times do
      b = stack.pop
      a = stack.pop
      c = a + b
      # puts "#{c} = #{a} + #{b}"
      stack.push(b)
      stack.push(c)
      num = c
    end
    num
  end

  def test_fibonacci
    assert_equal 34, stack_fibonacci(10)
  end
end
