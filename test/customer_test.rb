require 'minitest/autorun'
require 'minitest/pride'
require './lib/customer'

class CustomerTest < Minitest::Test

  def setup
    rows = CSV.open "./data/fixtures/customers_test.csv", headers: true, header_converters: :symbol
    read_rows = rows.read
    sales_engine = SalesEngine.new
    customer_repository = sales_engine.customer_repository
    @customer = Customer.new(read_rows, customer_repository)
  end

  def test_it_receives_data_at_initialize
    assert_equal 10, @customer.first_name.count
    assert_equal "Joey", @customer.first_name.first
  end
end
