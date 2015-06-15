require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test

  def test_it_exists
    assert SalesEngine.new
  end

  def test_it_responds_to_startup
    engine = SalesEngine.new
    assert true, engine.respond_to?(:startup)
  end

 def test_it_loads_customer_dependencies_on_startup
    engine = SalesEngine.new
    expected_customer = engine.customer_repository

    assert expected_customer, engine.startup
  end

  def test_it_loads_merchant_dependencies_on_startup
    engine = SalesEngine.new
    expected_merchant = engine.merchant_repository

    assert expected_merchant, engine.startup
  end

  def test_it_loads_invoice_dependencies_on_startup
    engine = SalesEngine.new
    expected_invoice = engine.invoice_repository

    assert expected_invoice, engine.startup
  end

  def test_it_loads_invoice_item_dependencies_on_startup
    engine = SalesEngine.new
    expected_invoice_item = engine.invoice_item_repository

    assert expected_invoice_item, engine.startup
  end

  def test_it_loads_item_dependencies_on_startup
    engine = SalesEngine.new
    expected_item = engine.item_repository

    assert expected_item, engine.startup
  end

  def test_it_loads_transaction_dependencies_on_startup
    engine = SalesEngine.new
    expected_transaction = engine.transaction_repository

    assert expected_transaction, engine.startup
  end
end
