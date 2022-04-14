# typed: true
require "sorbet-runtime"

module Corduroy
  module Search
    # Performs a binary search on an Array of Comparables
    # Time Complexity : O(log(n))
    class BinarySearch
      extend T::Sig

      sig { returns(Array) }
      attr_reader :collection

      sig { params(collection: Array).void }
      def initialize(collection:)
        @collection = collection # Collection must be ordered
      end

      sig { params(target: Comparable).returns(T.nilable(Integer)) }
      def find(target:)
        lower = 0
        upper = @collection.length - 1
        loop do
          current_idx = (lower + upper) / 2
          if @collection[current_idx] == target
            return current_idx
          elsif lower > upper
            # The lower bound is now above the upper bound
            # so the target is not present in the collection.
            return nil
          else
            if @collection[current_idx] < target
              # The target is above the current_idx, so we know it is above the
              # lower bound.
              lower = current_idx + 1
            else
              # The target is below the current_idx, so we know it is below the
              # upper bound.
              upper = current_idx - 1
            end
          end
        end
      end
    end
  end
end
