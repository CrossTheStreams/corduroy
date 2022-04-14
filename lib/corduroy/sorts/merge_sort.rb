# typed: true
require "sorbet-runtime"

module Corduroy
  module Sorts
    # Sort an Array of Comparables using the Merge Sort algorithm
    # Merge Sort recursively divides the collction in half, then merges the two halfs in a single sorted array
    # Time complexity is O(N*logN)
    class MergeSort
      extend T::Sig

      sig { returns(Array) }
      attr_reader :collection

      def initialize(collection:)
        @collection = collection
      end

      sig { params(array: T.nilable(Array)).returns(Array) }
      def sort(array=nil)
        array ||= @collection
        if array.length > 1
          # We find a mid point
          mid = array.length / 2

          # Divide into a left and right array
          left = array[0..(mid - 1)]
          right = array[mid..]

          # Recurse on the left
          sort(left)
          # Recurse on the right
          sort(right)

          # Assign some local vars for the merging ahead
          l = 0 # l will keep track of the left idx
          r = 0 # r will keep track of the right idx
          k = 0 # k will track additions to array

          # We use l and r to keep track of iterating through left and right
          # comparing elements in each and assigning array[k] to whichever is smaller
          # We do this until either l or r == left.length/right.length
          while l < left.length && r < right.length
            if left[l] < right[r]
              array[k] = left[l]
              l += 1
            else
              array[k] = right[r]
              r += 1
            end
            k += 1
          end

          # If we added all of right's elements and still haven't
          # added all of left's, we do that here
          while l < left.length
            array[k] = left[l]
            l += 1
            k += 1
          end

          # If we added all of left's elements and still haven't
          # added all of right's, we do that here
          while r < right.length
            array[k] = right[r]
            r += 1
            k += 1
          end
        end

        @collection = array if array.length == @collection.length
        array
      end
    end
  end
end
