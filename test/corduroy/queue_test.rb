# typed: true
require "test_helper"
require "corduroy/queue"

# Tests for Queue 
class TestQueue < Minitest::Test
  def setup
    @queue = Corduroy::Queue.new(max_size: 10)
  end

  def test_queue
    10.times do |n|
      @queue.insert(n)
    end
    assert @queue.full?
    assert_raises(Corduroy::Queue::Overflow) { @queue.insert(10) }
    (0..9).each do |n|
      assert_equal @queue.peek, n
      assert @queue.remove
    end
    assert @queue.empty?
    assert_raises(Corduroy::Queue::Underflow) { @queue.remove }

    # We should be able to remove items, add others,
    # then we exhaust the queue, we get the set we expect
    (0..9).each { |n| @queue.insert(n) }
    # 0, 1, 2 are out
    assert_equal (0..2).to_a, (3.times.map { @queue.remove })

    # 10 is in line now
    @queue.insert(10)
    # We expect 3..10, not 0, 1, or 2
    assert_equal (3..10).to_a, (8.times.map { @queue.remove })
  end
end
