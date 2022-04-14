# typed: true
require "sorbet-runtime"

# Sort an Array of Comparables using the Insertion Sort algorithm
# Insertion Sort is slow, but an improvement over both Bubble Sort and Selection Sort
# Time complexity is O(n^2)
module Corduroy
  module Sorts
    class InsertionSort
      extend T::Sig

      sig { returns(Array) }
      attr_reader :collection

      def initialize(collection:)
        @collection = collection
      end

      sig { returns(Array) }
      def sort
        (1..@collection.length - 1).each do |i|
          # i is a dividing line
          temp = @collection[i]
          j = i
          while j > 0 && @collection[j - 1] > temp
            @collection[j] = @collection[j - 1] # shift items to the right
            @collection[j -= 1] = temp          # assign smaller item to j - 1 and decrement j
          end
        end
        @collection
      end
    end
  end
end
