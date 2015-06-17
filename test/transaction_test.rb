require 'minitest/autorun'
require 'minitest/pride'
require '../lib/transaction'

class CustomerTest < Minitest::Test

  def setup
    rows = CSV.open "../data/fixtures/transactions_test.csv", headers: true, header_converters: :symbol
    read_rows = rows.read
    sales_engine = SalesEngine.new
    @transaction = Transaction.new(read_rows, sales_engine.transaction_repository)
  end

  def test_it_receives_data_at_initialize
    assert_equal "4654405418249632", @transaction.credit_card_number.first
    assert_equal "success", @transaction.result.first
  end
end
