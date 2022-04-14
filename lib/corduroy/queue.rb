# typed: true
require "sorbet-runtime"

module Corduroy
  # Implementation of an array-based Queue
  # A Queue allows you to collect a number items and remove them in the order of insertion, FIFO order
  class Queue
    extend T::Sig

    attr_reader :max_size
    attr_reader :front
    attr_reader :rear

    sig { params(max_size: Integer).void }
    def initialize(max_size:)
      @max_size = max_size
      @array = []
      @current_size = 0
      @front = 0
      @rear = -1
    end

    class Overflow < StandardError; end
    class Underflow < StandardError; end

    sig { params(item: T.untyped).returns(T.untyped) }
    def insert(item)
      raise(Overflow, "Cannot insert item into full Queue") if full?

      # Deal with a wrap-around
      #   We check if rear + 1 is @max_size, if so we decrement rear
      if @rear + 1 == @max_size
        @rear = -1
      end

      # After potentially dealing with wrap-around, we increment rear
      # It will be zero in that case
      @rear += 1
      @current_size += 1
      @array[@rear] = item
    end

    sig { returns(T.untyped) }
    def remove
      raise Underflow, "Cannot remove, Queue has no items" if empty?

      # Retrieve and return the item at the front
      @array[@front].tap do
        # Deal with a wrap-around:
        #   NOTE: We *first* increment front
        @front += 1
        #   Second: we check if equal to max_size here, set to zero if so
        #   Note how that occurred in opposite order of rear wrap-around in insert
        @front = 0 if @front == @max_size
        @current_size -= 1
      end
    end

    sig { returns(T.untyped) }
    def peek
      @array[@front]
    end

    sig { returns(T::Boolean) }
    def empty?
      @current_size == 0
    end

    sig { returns(T::Boolean) }
    def full?
      @current_size == @max_size
    end

    sig { returns(Integer) }
    def size
      @current_size
    end
  end
end
