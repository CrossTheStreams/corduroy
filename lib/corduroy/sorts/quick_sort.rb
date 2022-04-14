# typed: true
require "sorbet-runtime"

module Corduroy
  module Sorts
    # Sort an Array of Comparables using the Quick Sort algorithm
    # Time complexity is Ω(n log(n)), O(n^2) if we happen to pick the largest value
    # Space complexity is O(log(n))
    class QuickSort
      extend T::Sig

      sig { returns(Array) }
      attr_reader :collection

      def initialize(collection:)
        @collection = collection
      end

      sig { returns(Array) }
      def sort
        quick_sort(array: @collection, left: 0, right: @collection.length - 1)
        @collection
      end

      private

      sig { params(array: Array, left: Integer, right: Integer).void }
      def quick_sort(array:, left:, right:)
        index = partition(array: array, left: left, right: right)
        if left < index - 1
          quick_sort(array: array, left: left, right: index - 1)
        end
        if index < right
          quick_sort(array: array, left: index, right: right)
        end
      end

      sig { params(array: Array, left: Integer, right: Integer).returns(Integer) }
      def partition(array:, left:, right:)
        # Find the pivot
        pivot = array[left + (right - left) / 2]
        while left <= right
          while array[left] < pivot
            left += 1
          end
          while array[right] > pivot
            right -= 1
          end
          next if left > right

          array[left], array[right] = array[right], array[left]
          left += 1
          right -= 1
        end
        left
      end
    end
  end
end
