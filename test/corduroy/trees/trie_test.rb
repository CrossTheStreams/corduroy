# typed: true
require "test_helper"
require "corduroy/trees/trie"

class TestTrie < Minitest::Test
  def setup
    @trie = Corduroy::Trees::Trie.new
  end

  def test_search
    assert_equal(false, @trie.search("apple"))
    @trie.insert("apple")
    assert @trie.search("apple")
    assert_equal(false, @trie.search("app"))
    @trie.insert("app")
    assert(@trie.search("app"))
    assert_equal(false, @trie.search("definitelynotanapple"))
  end

  def test_starts_with
    @trie.insert("apple")
    assert @trie.starts_with("app")
    assert @trie.starts_with("apple")
    assert_equal(false, @trie.starts_with("pple"))
  end
end
