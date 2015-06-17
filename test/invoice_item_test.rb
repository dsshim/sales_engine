require 'minitest/autorun'
require 'minitest/pride'
require '../lib/invoice'

class InvoiceItemTest < Minitest::Test

  def setup
    rows = CSV.open "../data/fixtures/invoice_items_test.csv", headers: true, header_converters: :symbol
    read_rows = rows.read
    sales_engine = SalesEngine.new
    @invoice_item = InvoiceItem.new(read_rows, sales_engine.customer_repository)
  end

  def test_it_receives_data_at_initialize
    assert_equal 50, @invoice_item.id.count
    assert_equal "539", @invoice_item.item_id.first
  end
end
