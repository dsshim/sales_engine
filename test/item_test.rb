require "minitest/autorun"
require "minitest/pride"
require "./lib/item"
class ItemTest < Minitest::Test

  attr_reader :data

  def setup
    @data = {
      id: 1,
      name: "Item Qui Esse",
      description: "Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.",
      unit_price: 75107,
      merchant_id: 1,
      created_at: "2012-03-27 14:53:59 UTC",
      updated_at: "2012-03-27 14:53:59 UTC"
    }
  end

  def test_it_receives_data_at_initialize
    item = Item.new(data, nil)
    assert_equal "Item Qui Esse", item.name
    assert_equal 75107, item.unit_price
  end

  def test_it_returns_a_collection_of_invoice_items
    repository = Minitest::Mock.new
    item = Item.new(data, repository)
    repository.expect(:find_items_by_id, nil, [1])
    item.invoice_items
    repository.verify
  end

  def test_it_returns_a_collection_merchants
    repository = Minitest::Mock.new
    item = Item.new(data, repository)
    repository.expect(:find_merchants_by_id, nil, [1])
    item.merchants
    repository.verify
  end
end
