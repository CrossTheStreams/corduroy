# typed: true

require "test_helper"
require "corduroy/trees/binary_search_tree"

# Tests for BinarySearchTree
class TestBinarySearchTree < Minitest::Test
  extend T::Sig

  def setup
    @bst = Corduroy::Trees::BinarySearchTree.new

    preshuffled_nums = [10, 8, 3, 1, 9, 6, 5, 2, 7, 4]
    preshuffled_nums.each { |n| @bst.insert(n) }
  end

  def test_insert_and_traversals
    inorder_arr = (1..10).to_a
    assert_equal(inorder_arr, @bst.inorder_traversal.to_a)

    preorder_arr = [10, 8, 3, 1, 2, 6, 5, 4, 7, 9]
    assert_equal(preorder_arr, @bst.preorder_traversal.to_a)

    postorder_arr = [2, 1, 4, 5, 7, 6, 3, 9, 8, 10]
    assert_equal(postorder_arr, @bst.postorder_traversal.to_a)
  end

  def test_find
    seven_node = @bst.root.left.left.right.right
    assert_equal(seven_node, @bst.find(7))
  end

  def test_delete
    assert_equal(false, @bst.delete(11))
    assert_equal((1..10).to_a, @bst.inorder_traversal.to_a)

    assert(@bst.delete(3))
    three_deleted_arr = (1..10).to_a.reject { |n| n == 3 }
    assert_equal(three_deleted_arr, @bst.inorder_traversal.to_a)
  end
end
