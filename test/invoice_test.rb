require 'minitest/autorun'
require 'minitest/pride'
require '../lib/invoice'

class InvoiceTest < Minitest::Test

  def setup
    rows = CSV.open "../data/fixtures/invoices_test.csv", headers: true, header_converters: :symbol
    read_rows = rows.read
    sales_engine = SalesEngine.new
    @invoice = Invoice.new(read_rows, sales_engine.customer_repository)
  end

  def test_it_receives_data_at_initilaize
    assert_equal 50, @invoice.customer_id.count
    assert_equal "26", @invoice.merchant_id.first
  end
end
