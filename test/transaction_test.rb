require 'minitest/autorun'
require 'minitest/pride'
require './lib/transaction'

class TransactionTest < Minitest::Test

  attr_reader :data

  def setup
    @data = {
        id: 1,
        invoice_id: 2,
        credit_card_number: "4654405418249632",
        credit_card_expiration_date: "",
        result: "success",
        created_at: "2012-03-27 14:54:09 UTC",
        updated_at: "2012-03-27 14:54:10 UTC"
    }
  end

  def test_it_receives_data_at_initialize
    transaction = Transaction.new(data, nil)
    assert_equal "4654405418249632", transaction.credit_card_number
    assert_equal "success", transaction.result
  end

  def test_it_returns_a_collection_of_invoices
    sales_engine = SalesEngine.new(data)
    transaction = sales_engine.transaction_repository.find_by_id(2)

    expected = transaction.invoice.customer.first_name
    assert_equal "Joey", expected
  end
end
