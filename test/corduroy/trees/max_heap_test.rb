# typed: true

require "test_helper"
require "corduroy/trees/max_heap"

class TestMaxHeap < Minitest::Test
  def setup
    @max_heap = Corduroy::Trees::MaxHeap.new
  end

  def test_insert
    (0..99).to_a.shuffle.each { |n| @max_heap.insert(n) }
    vals = []

    100.times { vals << @max_heap.pop }
    assert_equal (0..99).to_a.reverse, vals
  end

  def test_heapify
    arr = (0..99).to_a.shuffle
    max_heap = Corduroy::Trees::MaxHeap.heapify(arr)
    vals = []
    100.times { vals.push(max_heap.pop) }
    assert_equal (0..99).to_a.reverse, vals
  end

  def test_change
    max_heap = Corduroy::Trees::MaxHeap.heapify((0..99).to_a.shuffle)
    changed_val = max_heap.array[99]
    max_heap.change(index: 99, new_value: 200)
    vals = []
    100.times { vals.push(max_heap.pop) }
    refute_includes(vals, changed_val)
    assert_equal(200, vals.first)

    max_heap = Corduroy::Trees::MaxHeap.heapify((0..99).to_a.shuffle)
    changed_val = max_heap.array[0]
    max_heap.change(index: 0, new_value: -1)
    vals = []
    100.times { vals.push(max_heap.pop) }
    refute_includes(vals, changed_val)
    assert_equal(-1, vals.last)
  end
end
