require 'csv'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant'

class MerchantTest < Minitest::Test

  def setup
    rows = CSV.open "./data/fixtures/merchants_test.csv", headers: true, header_converters: :symbol
    read_rows = rows.read
    sales_engine = SalesEngine.new
    merchant_repository = sales_engine.merchant_repository
    @merchants = Merchant.new(read_rows, merchant_repository)
  end

  def test_it_receives_data_at_initialize
    assert_equal 39, @merchants.name.count
    assert_equal "Schroeder-Jerde", @merchants.name.first
  end
end
