# typed: true

require "sorbet-runtime"

module Corduroy
  module Trees
    # An implementation of a min heap
    # https://en.wikipedia.org/wiki/?curid=13996
    class MinHeap
      extend T::Sig

      class MaxSizeError < StandardError
      end

      sig { returns(Array) }
      attr_reader :array

      def initialize
        @current_size = 0
        @array = []
      end

      sig { params(array: Array).returns(Corduroy::Trees::MinHeap) }
      def self.heapify(array)
        min_heap = Corduroy::Trees::MinHeap.new
        min_heap.instance_variable_set(:@array, array)
        min_heap.instance_variable_set(:@current_size, array.length)
        min_heap.heapify_array(index: 0)
        min_heap
      end

      sig { params(value: Integer).returns(Integer) }
      def insert(value)
        @array[@current_size] = value
        trickle_up(index: @current_size)
        @current_size += 1
      end

      sig { returns(Integer) }
      def pop
        root = @array[0]
        @array[0] = @array[@current_size - 1]
        @current_size -= 1
        trickle_down(index: 0)
        root
      end

      sig { params(index: Integer, new_value: Integer).returns(T::Boolean) }
      def change(index:, new_value:)
        if index < 0 || index >= @current_size
          return false
        end

        old_value = @array[index]
        @array[index] = new_value

        if old_value > new_value
          trickle_up(index: index)
        else
          trickle_down(index: index)
        end

        true
      end

      sig { params(index: Integer).void }
      def heapify_array(index:)
        if index > ((@current_size / 2) - 1)
          # Don't do anything, we're at a node with no children
        else
          heapify_array(index: (index * 2) + 2)
          heapify_array(index: (index * 2) + 1)
          trickle_down(index: index)
        end
      end

      def to_s
        "#<Corduroy::Trees::MinHeap #{@array} >"
      end

      private

      # index is the index of the item we're removing
      sig { params(index: Integer).void }
      def trickle_down(index:)
        # puts "tricket_down index => #{index}"
        smaller_child = 0
        # root
        top = @array[index]

        # while node has at least one child
        while index < @current_size / 2
          # find the smaller child
          left_child = 2 * index + 1
          right_child = left_child + 1

          if right_child < @current_size && @array[left_child] > @array[right_child]
            smaller_child = right_child
          else
            smaller_child = left_child
          end

          # top is smaller, nothing to do
          if top <= @array[smaller_child]
            break
          end

          # shift child up, it's smaller
          @array[index] = @array[smaller_child]

          # go down
          index = smaller_child
        end

        @array[index] = top
        nil
      end

      # index is the index of the item we're inserting
      sig { params(index: Integer).void }
      def trickle_up(index:)
        parent = (index - 1) / 2
        bottom = @array[index]

        if bottom
          while index > 0 && @array[parent] > bottom
            @array[index] = @array[parent]
            index = parent
            parent = (parent - 1) / 2 # parent equals grandpa
          end
          @array[index] = bottom
        end
        nil
      end
    end
  end
end
