# typed: true
require "test_helper"
require "corduroy/sorts/merge_sort"

# A test of BinarySearch
class TestMergeSort < Minitest::Test
  def setup
    @collection = (0..99).to_a.shuffle
    @sort = Corduroy::Sorts::MergeSort.new(collection: @collection)
  end

  def test_sort
    refute_equal @collection, (0..99).to_a
    assert_equal @sort.sort, (0..99).to_a
  end
end
