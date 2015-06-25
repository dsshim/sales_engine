require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice'
require 'pry'

class InvoiceTest < Minitest::Test

  attr_reader :data

  def setup
    @data = {
        id: 1,
        customer_id: 2,
        merchant_id: 41,
        status: "shipped",
        created_at: "2012-03-25 09:54:09 UTC",
        updated_at: "2012-03-25 09:54:09 UTC"
    }
  end

  def test_it_receives_data_at_initialize
    invoice = Invoice.new(data, nil)
    assert_equal 2, invoice.customer_id
    assert_equal 41, invoice.merchant_id
  end

  def test_it_returns_a_collecton_of_transactions
    repository = Minitest::Mock.new
    invoice = Invoice.new(data, repository)
    repository.expect(:find_invoices_by_invoice_id, nil, [1])
    invoice.transactions
    repository.verify
  end

  def test_it_returns_a_collection_of_merchants
    repository = Minitest::Mock.new
    invoice = Invoice.new(data, repository)
    repository.expect(:find_merchant_invoices_by_id, nil, [1])
    invoice.merchant
    repository.verify
  end

  def test_it_returns_a_collection_of_invoice_items
    sales_engine = SalesEngine.new(data)
    expected = sales_engine.invoice_repository.find_by_id(1).
        invoice_items.size

    assert_equal 8, expected
  end

  def test_it_returns_a_collection_of_items_through_invoice_items
    sales_engine = SalesEngine.new(data)
    expected = sales_engine.invoice_repository.find_by_id(1)
                  .items.size

    assert_equal 8, expected
  end

  def test_it_returns_a_collection_of_customers # rewrite with dummy data
    sales_engine = SalesEngine.new(data)
    expected = sales_engine.invoice_repository.find_by_id(1)
                  .customer.first_name

    assert_equal "Joey", expected
  end


  def test_it_creates_invoices_and_transactions
    sales_engine = SalesEngine.new(data)
    customer_repo = sales_engine.customer_repository
    merchant_repo = sales_engine.merchant_repository
    item_repo = sales_engine.item_repository
    invoice_repo = sales_engine.invoice_repository
    transaction_repo = sales_engine.transaction_repository

    customer = customer_repo.find_by_id(7)
    merchant = merchant_repo.find_by_id(87)
    items = (1..3).map { item_repo.random }

    invoice = invoice_repo.create(customer: customer, merchant: merchant, items: items)

    expected = invoice_repo.all.last.customer_id
    assert_equal 7, expected

    invoice.charge(credit_card_number: "123456789012",
                   credit_card_expiration_date: "07/21",
                   result: "success")

    assert_equal "123456789012", transaction_repo.all.last.credit_card_number
  end
end
