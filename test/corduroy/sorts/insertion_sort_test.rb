# typed: true
require "test_helper"
require "corduroy/sorts/insertion_sort"

# A test of BinarySearch
class TestInsertionSort < Minitest::Test
  def setup
    @collection = (0..99).to_a.shuffle
    @sort = Corduroy::Sorts::InsertionSort.new(collection: @collection)
  end

  def test_sort
    assert_equal Corduroy::Sorts::InsertionSort.new(collection: []).sort, []
    refute_equal @collection, (0..99).to_a
    assert_equal @sort.sort, (0..99).to_a
  end
end
