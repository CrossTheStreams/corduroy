# typed: true

require "sorbet-runtime"
require "corduroy/stack"

module Corduroy
  module Trees
    class BinarySearchTree
      extend T::Sig

      attr_reader :root

      class Node
        extend T::Sig

        sig { returns(Comparable) }
        attr_accessor :data

        sig { returns(T.nilable(Node)) }
        attr_accessor :left, :right
      end

      sig { params(data: Comparable).returns(T.nilable(Node)) }
      def find(data)
        return nil if @root.nil?

        current = @root
        loop do
          return current if data == current.data

          if data < current.data
            if current.left
              current = current.left
            else
              return nil
            end
          elsif data > current.data
            if current.right
              current = current.right
            else
              return nil
            end
          end
        end
      end

      sig { params(data: Comparable).void }
      def insert(data)
        new_node = Node.new
        new_node.data = data

        if @root.nil?
          @root = new_node # add new node as root
        else # root is occupied
          current = @root # start at the root
          loop do
            parent = current
            if data < current.data # go left?
              current = current.left
              if current.nil?
                parent.left = new_node
                return # return after adding new node
              else
                next # next iteration
              end
            else # go right?
              current = current.right
              if current.nil?
                parent.right = new_node
                return # return after adding new node
              else
                next # next iteration
              end
            end
          end
        end
      end

      sig { params(data: Comparable).returns(T::Boolean) }
      def delete(data)
        left_child = T.let(true, T::Boolean)
        current = @root
        parent = @root

        while data != current.data
          parent = current

          if data < current.data
            left_child = true
            current = current.left
          elsif data > current.data
            left_child = false
            current = current.right
          end

          # we couldn't find it, return false
          return false if current.nil?
        end

        # we found the node
        # disconnect from its parent:
        if current.left.nil? && current.right.nil? # no children
          if current == @root
            @root = nil
          elsif left_child
            parent.left = nil
          else
            parent.right = nil
          end
        elsif current.right.nil? # has just the left child
          if current == @root
            @root = current.left
          elsif left_child
            parent.left = current.left
          else
            parent.right = current.left
          end
        elsif current.left.nil? # has just the right child
          if current == @root
            @root = current.right
          elsif left_child
            parent.left = current.right
          else
            parent.right = current.right
          end
        else # has both children
          successor = get_successor(current)
          if current == @root
            @root = successor
          elsif left_child
            parent.left = successor
          else
            parent.right = successor
          end
          # connect successor to current's left child
          successor.left = current.left
        end
        true
      end

      # left, root, right
      # get items in tree in ascending order
      sig { returns(T::Enumerator[Comparable]) }
      def inorder_traversal
        return Enumerator.new {} if @root.nil?

        current = T.let(@root, T.nilable(Node)) # set current to root node
        Enumerator.new { |yielder| inorder(current, yielder) }
        # NOTE: alternative stack based approach to inorder traversal
        # stack = Corduroy::Stack.new # init stack
        # current = T.let(@root, T.nilable(Node)) # set current to root node
        # Enumerator.new do |yielder|
        #   loop do
        #     if current.nil?
        #       # we navigated to a nil node previously
        #       if stack.empty?
        #         # we're all done! time to stop
        #         break
        #       else
        #         # pass top of stack to the yielder
        #         node = stack.pop
        #         yielder << node.data
        #         # navigate right
        #         current = node.right
        #       end
        #     else
        #       # add current node to stack
        #       stack.push(current)
        #       # navigate left
        #       current = current.left
        #     end
        #   end
        # end
      end

      # root, left, right
      # used to copy the tree
      sig { returns(T::Enumerator[Comparable]) }
      def preorder_traversal
        return Enumerator.new {} if @root.nil?

        current = T.let(@root, T.nilable(Node)) # set current to root node
        Enumerator.new { |yielder| preorder(current, yielder) }
      end

      # left, right, root
      # used to delete the tree
      sig { returns(T::Enumerator[Comparable]) }
      def postorder_traversal
        return Enumerator.new {} if @root.nil?

        current = T.let(@root, T.nilable(Node)) # set current to root node
        Enumerator.new { |yielder| postorder(current, yielder) }
      end

      private

      sig { params(node: T.nilable(Node), yielder: Enumerator::Yielder).void }
      def inorder(node, yielder)
        if node
          inorder(node.left, yielder)
          yielder << node.data
          inorder(node.right, yielder)
        end
      end

      sig { params(node: T.nilable(Node), yielder: Enumerator::Yielder).void }
      def preorder(node, yielder)
        if node
          yielder << node.data
          preorder(node.left, yielder)
          preorder(node.right, yielder)
        end
      end

      sig { params(node: T.nilable(Node), yielder: Enumerator::Yielder).void }
      def postorder(node, yielder)
        if node
          postorder(node.left, yielder)
          postorder(node.right, yielder)
          yielder << node.data
        end
      end

      sig { params(node: Node).returns(Node) }
      def get_successor(node)
        successor_parent = node
        successor = node
        current = T.let(node.right, T.nilable(Node))

        until current.nil?
          successor_parent = successor
          successor = current
          current = current.left
        end

        # if successor not right child
        # make connections
        if successor != node.right
          successor_parent.left = successor.right
          successor.right = node.right
        end

        successor
      end
    end
  end
end
