require_relative 'test_helper.rb'
require './lib/invoice'
require './lib/invoice_item_repository'

class InvoiceItemTest < Minitest::Test

  attr_reader :data

  def setup
    @data = {
        id: 1,
        item_id: 530,
        invoice_id: 2,
        quantity: 9,
        created_at: "2012-03-27 14:54:09 UTC",
        updated_at: "2012-03-27 14:54:09 UTC"
    }
  end

  def test_it_receives_data_at_initialize
    invoice_item = InvoiceItem.new(data, nil)
    assert_equal 1, invoice_item.id
    assert_equal 530, invoice_item.item_id
  end

  def test_it_can_find_a_record
    invoice_item = SalesEngine.new(data).invoice_item_repository.find_by_item_id(2)
    expected = invoice_item.item.name
    assert_equal "Item Autem Minima", expected
  end

  def test_it_returns_a_collection_of_invoices
    invoice_items = SalesEngine.new(data).invoice_item_repository.find_all_by_quantity(10)
    expected = invoice_items.size
    assert_equal 2140, expected

  end

  def test_it_returns_a_collection_of_items
    invoice_item = SalesEngine.new(data).invoice_item_repository.find_by_id(530)
    expected = invoice_item.item.name
    assert_equal "Item Facilis Sit", expected
  end
end
