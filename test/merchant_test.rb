require 'csv'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant'

class MerchantTest < Minitest::Test

  attr_reader :sales_engine, :rows, :merchant_repository, :merchant

  def setup
    # rows = CSV.read "./data/fixtures/merchants_test.csv", headers: true, header_converters: :symbol
    @sales_engine ||= SalesEngine.new
    @merchant_repository = sales_engine.merchant_repository
    @merchant = merchant_repository.merchants
  end

  def test_it_receives_data_at_initialize
    assert_equal 39, merchant.name.count
    assert_equal "Schroeder-Jerde", merchant.name.first
  end

  def test_it_returns_a_collection_of_items_associated_with_merchant_id
    assert_equal 4, merchant.merchant_items(4).count
  end
end

# items returns a collection of Item instances associated with that merchant for the products they sell
# invoices returns a collection of Invoice instances associated with that merchant from their known orders
