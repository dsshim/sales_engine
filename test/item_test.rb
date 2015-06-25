require_relative 'test_helper.rb'
require "./lib/item"

class ItemTest < Minitest::Test

  attr_reader :data

  def setup
    @data = {

      id:           1,
      name:         "Item Qui Esse",
      description:  "Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.",
      unit_price:   75107,
      merchant_id:  1,
      created_at:   "2012-03-27 14:53:59 UTC",
      updated_at:   "2012-03-27 14:53:59 UTC"
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

  def test_it_returns_the_date_with_most_sales_by_invoice_date
    sales_engine = SalesEngine.new(data)
    expected = sales_engine.item_repository
                   .find_by_name("Item Accusamus Ut").best_day

    assert_equal Date.new(2012, 3, 24), expected
  end

  def test_it_returns_a_collection_merchants
    sales_engine = SalesEngine.new(data)
    item = sales_engine.item_repository.find_by_name "Item Qui Esse"

    expected = item.merchant.name

    assert_equal "Schroeder-Jerde", expected
  end
end
