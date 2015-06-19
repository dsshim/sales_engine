require 'csv'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant'

class MerchantTest < Minitest::Test

  attr_reader :data, :sales_engine

  def setup
    @data = {
      id: 1,
      name: "Schroeder-Jerde",
      created_at: "2012-03-27 14:53:59 UTC",
      updated_at: "2012-03-27 14:53:59 UTC"
    }
  end

  def test_it_receives_its_id_at_initialize
    merchant = Merchant.new(data, nil)
    assert_equal 1, merchant.id
  end

  def test_it_receives_its_name_at_initialize
    merchant = Merchant.new(data, nil)
    assert_equal "Schroeder-Jerde", merchant.name
  end

  def test_it_receives_its_creation_date_at_initialize
    merchant = Merchant.new(data, nil)
    assert_equal "2012-03-27 14:53:59 UTC", merchant.created_at
  end

  def test_it_receives_its_update_date_at_initialize
    merchant = Merchant.new(data, nil)
    assert_equal "2012-03-27 14:53:59 UTC", merchant.updated_at
  end

  def test_it_returns_a_collection_of_items_associated_with_merchant_id
    repository = Minitest::Mock.new
    merchant = Merchant.new(data, repository)
    repository.expect(:find_items_by_merchant_id, nil, [1])
    merchant.items
    repository.verify
  end

  def test_it_returns_a_collection_of_invoices_with_merchant_id
    repository = Minitest::Mock.new
    merchant = Merchant.new(data, repository)
    repository.expect(:find_invoices_by_merchant_id, nil, [1])
    merchant.invoices
    repository.verify
  end

  def test_it_returns_total_revenue
    repository = Minitest::Mock.new
    merchant = Merchant.new(data, repository)
    #repository.expect(:find_invoices_by_merchant_id, 2, [1])
    repository.expect(:find_transactions_by_invoice_id, 2, [1])
    merchant.revenue
    repository.verify
  end

end

# items returns a collection of Item instances associated with that merchant for the products they sell
# invoices returns a collection of Invoice instances associated with that merchant from their known orders
