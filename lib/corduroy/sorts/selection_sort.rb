# typed: true
require "sorbet-runtime"

module Corduroy
  module Sorts
    # Sort an Array of Comparables using the Selection Sort algorithm
    # Selection Sort is slow, but an improvement over the very naive Bubble Sort
    # Time complexity is O(n^2)
    # Selection Sort makes the same number of comparisions as Bubble Sort, but makes many fewer
    # swaps
    class SelectionSort
      extend T::Sig

      sig { returns(Array) }
      attr_reader :collection

      def initialize(collection:)
        @collection = collection
      end

      sig { returns(Array) }
      def sort
        (0..@collection.length - 2).each do |i|
          # We assign min_idx = i 
          min_idx = i
          (i + 1..@collection.length - 1).each do |j|
            # if we find an item smaller than the item at min_idx as we go through @collection in the inner loop
            # we place it at min_idx
            min_idx = j if @collection[j] < @collection[min_idx]
          end
          # then we place the item that was at min_idx to @collection[idx], once we're again in the outer loop
          @collection[i], @collection[min_idx] = @collection[min_idx], @collection[i]
        end
        @collection
      end
    end
  end
end
