require 'csv'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant'
require './lib/merchant_repository'
require './lib/sales_engine'

class MerchantTest < Minitest::Test

  attr_reader :data, :sales_engine, :merchant_repository

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

  def test_it_returns_total_revenue_by_merchant
    sales_engine = SalesEngine.new(data)
    expected = sales_engine.merchant_repository.find_by_id(1)
                   .revenue

    assert_equal BigDecimal.new("528774.64"), expected
  end

  def test_it_returns_total_revenue_for_given_date
    sales_engine = SalesEngine.new(data)
    expected = sales_engine.merchant_repository.find_by_name("Schroeder-Jerde")
                   .revenue(Date.parse "Fri, 09 Mar 2012")

    assert_equal BigDecimal.new("8661.4"), expected
  end

  def test_it_returns_favorite_customer
    sales_engine = SalesEngine.new(data)
    expected = sales_engine.merchant_repository.find_by_name("Schroeder-Jerde")
                   .favorite_customer.first_name

    assert_equal "Parker", expected
  end

  def test_it_returns_customers_with_pending_invoices
    sales_engine = SalesEngine.new(data)
    expected = sales_engine.merchant_repository.find_by_name("Schroeder-Jerde")
                   .customers_with_pending_invoices.count

    assert_equal 3, expected
  end
end
