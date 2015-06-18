require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice'

class InvoiceTest < Minitest::Test

  attr_reader :data

  def setup
    @data = {
      id: "1",
      customer_id: "2",
      merchant_id: "41",
      status: "shipped",
      created_at: "2012-03-25 09:54:09 UTC",
      updated_at: "2012-03-25 09:54:09 UTC"
    }
  end

  def test_it_receives_data_at_initilaize
    invoice = Invoice.new(data, nil)
    assert_equal "2", invoice.customer_id
    assert_equal "41", invoice.merchant_id
  end

  def test_it_returns_a_collecton_of_transactions
    repository = Minitest::Mock.new
    invoice = Invoice.new(data, repository)
    repository.expect(:find_invoices_by_invoice_id, nil, ["1"])
    invoice.transactions
    repository.verify
  end

  def test_it_returns_a_collection_of_invoice_items
    repository = Minitest::Mock.new
    invoice = Invoice.new(data, repository)
    repository.expect(:find_items_by_invoice_id_thru_invoice_items, nil, ["1"])
    invoice.invoice_items
    repository.verify
  end

  def test_it_returns_a_collection_of_items_through_invoice_items
    repository = Minitest::Mock.new
    invoice = Invoice.new(data, repository)
    repository.expect(:find_items_by_invoice_item, nil, ["1"])
    invoice.items
    repository.verify
  end

  def test_it_returns_a_collection_of_customers
    repository = Minitest::Mock.new
    invoice = Invoice.new(data, repository)
    repository.expect(:find_invoices_by_customer_id, nil, ["1"])
    invoice.customers
    repository.verify
  end

  def test_it_returns_a_collection_of_merchants
    repository = Minitest::Mock.new
    invoice = Invoice.new(data, repository)
    repository.expect(:find_merchant_invoices_by_id, nil, ["1"])
    invoice.merchants
    repository.verify
  end
end
