require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test

  def test_it_exists
    assert SalesEngine.new
  end

  def test_it_responds_to_startup
    engine = SalesEngine.new
    assert true, engine.respond_to?(:startup)
  end
end
