require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice'

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

  def test_it_returns_a_collection_of_invoices
    repository = Minitest::Mock.new
    invoice_item = InvoiceItem.new(data, repository)
    repository.expect(:find_invoice_items_by_invoice_id, nil, [1])
    invoice_item.invoices
    repository.verify
  end

  def test_it_returns_a_collection_of_items
    repository = Minitest::Mock.new
    invoice_item = InvoiceItem.new(data, repository)
    repository.expect(:find_invoice_items_by_item_id, nil, [1])
    invoice_item.item
    repository.verify
  end
end
