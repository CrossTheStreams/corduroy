# typed: true
require "sorbet-runtime"

module Corduroy
  module Sorts
    # A notoriously slow sorting algorithm that's easy to reason about
    # Time complexity is O(n^2)
    class BubbleSort
      extend T::Sig

      sig { returns(Array) }
      attr_reader :collection

      sig { params(collection: Array).void }
      def initialize(collection:)
        @collection = collection
      end

      sig { returns(Array) }
      def sort
        # An outer loop starts at the end of the collection and works backward from there
        (0..(@collection.length - 1)).each do |n|
          right = (@collection.length - 1) - n # Right boundary on the iteration
          left = 0 # We always start on the first element in the collection
          while left < right
            # Starting from @collection[left] and working up, compare left to its right
            # We swap them if @collection[left] is bigger
            if @collection[left] > @collection[left + 1]
              @collection[left], @collection[left + 1] = @collection[left + 1], @collection[left]
            end
            left += 1
          end
        end
        @collection
      end
    end
  end
end
