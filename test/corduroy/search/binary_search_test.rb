# typed: true
require "test_helper"
require "corduroy/search/binary_search"

# A test of Corduroy::Search::BinarySearch
class TestBinarySearch < Minitest::Test
  def setup
    @collection = (-100_000_000..100_000_000).to_a
    @target = 8_765_309
    @search = Corduroy::Search::BinarySearch.new(collection: @collection)
  end

  def test_find
    # empty collection
    assert_nil Corduroy::Search::BinarySearch.new(collection: [].to_a).find(target: 0)

    # can find stuff
    assert_equal 0, Corduroy::Search::BinarySearch.new(collection: [0].to_a).find(target: 0)
    assert_equal 7, Corduroy::Search::BinarySearch.new(collection: (1..10).to_a).find(target: 8)
    assert_equal 19, Corduroy::Search::BinarySearch.new(collection: (-11..10).to_a).find(target: 8)
    assert_equal 108_765_309, @search.find(target: @target)

    # can't find things that aren't in collection
    assert_nil Corduroy::Search::BinarySearch.new(collection: (0..10).to_a).find(target: 999)
    assert_nil Corduroy::Search::BinarySearch.new(collection: (1..10).to_a).find(target: 0)
    assert_nil Corduroy::Search::BinarySearch.new(collection: (0..100).to_a).find(target: 101)
  end
end
