# typed: strict
# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "corduroy"
require "minitest/autorun"
require "minitest/benchmark"
require "minitest/reporters"
require "sorbet-runtime"

Minitest::Reporters.use! [Minitest::Reporters::SpecReporter.new]
