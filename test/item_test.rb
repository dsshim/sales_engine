require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'

class ItemTest < Minitest::Test

  def setup
  rows = CSV.open "./data/fixtures/item_test.csv", headers: true, header_converters: :symbol
  read_rows = rows.read
  sales_engine = SalesEngine.new
  item_repository = sales_engine.item_repository
  @items = Item.new(read_rows, item_repository)
  end

  def test_it_receives_data_at_initialize
    assert_equal 40, @items.name.count
    assert_equal "Item Qui Esse", @items.name.first
  end

end
