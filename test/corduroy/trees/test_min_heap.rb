# typed: true
require "test_helper"
require "corduroy/trees/min_heap"

# A test of BinarySearch
class TestMinHeap < Minitest::Test
  def setup
    @min_heap = Corduroy::Trees::MinHeap.new(max_size: 100)
  end

  def test_insert
    (0..99).to_a.shuffle.each {|n| @min_heap.insert(n) }
    vals = []
    100.times { |i| vals << @min_heap.extract! }
    assert_equal vals, (0..99).to_a
  end

  def test_heapify
    arr = (0..99).to_a.shuffle
    min_heap = Corduroy::Trees::MinHeap.heapify(arr)
    vals = []
    100.times { vals.push(min_heap.extract!) }
    assert_equal (0..99).to_a, vals
  end

  def test_change
    min_heap = Corduroy::Trees::MinHeap.heapify((0..99).to_a.shuffle)
    min_heap.change(index: 0, new_value: 200)
    vals = []
    100.times { vals.push(min_heap.extract!) }
    refute_includes(vals, 0)
    assert_equal(vals[-1], 200)

    min_heap = Corduroy::Trees::MinHeap.heapify((0..99).to_a.shuffle)
    changed_val = min_heap.array[99]
    min_heap.change(index: 99, new_value: -1)
    vals = []
    100.times { vals.push(min_heap.extract!) }
    refute_includes(vals, changed_val)
    assert_includes(vals, -1)
  end
end
