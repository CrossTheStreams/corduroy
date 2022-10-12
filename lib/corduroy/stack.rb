# typed: true

require "sorbet-runtime"

module Corduroy
  # Implementation of a Stack
  # A Stack will allow you to add items to the Stack, then push them out later in FILO order
  class Stack
    extend T::Sig

    sig { returns(Array) }
    attr_reader :array

    sig { returns(Integer) }
    attr_reader :top

    sig { void }
    def initialize
      @array = []
      @top = -1
    end

    class Underflow < StandardError; end

    sig { params(item: T.untyped).returns(T.untyped) }
    def push(item)
      # We increment the top of the stack, then add new item
      @top += 1
      @array[@top] = item
    end

    sig { returns(T.untyped) }
    def pop
      raise Underflow, "Cannot remove, Stack has no items" if @top == -1

      # We retrieve the item to be popped
      @array[@top].tap do
        # Decrement the top
        @top -= 1
      end
    end

    sig { returns(T.untyped) }
    def peek
      @array[@top]
    end

    sig { returns(T::Boolean) }
    def empty?
      @top == -1
    end
  end
end
