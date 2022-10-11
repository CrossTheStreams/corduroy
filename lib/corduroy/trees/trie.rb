module Corduroy
  module Trees
    # An implementation of a trie
    # https://en.wikipedia.org/wiki/Trie
    class Trie
      attr_accessor :paths
      attr_accessor :word

      def initialize
        @paths = {}
        @word = false
      end

      def insert(prefix)
        node = self
        chars = ""
        prefix.each_char do |char|
          chars += char
          next_node = node.paths[chars]
          unless next_node
            next_node = Trie.new
            node.paths[chars] = next_node
          end
          node = next_node
        end
        node.word = true
        node
      end

      def search(prefix)
        node = self
        chars = ""
        prefix.each_char do |char|
          node = node.paths[chars += char]
          return false if node.nil?
        end
        node&.word?
      end

      def starts_with(prefix)
        node = self
        chars = ""
        prefix.each_char do |char|
          node = node.paths[chars += char]
          return false if node.nil?
        end
        !!node
      end

      def word?
        !!@word
      end
    end
  end
end
