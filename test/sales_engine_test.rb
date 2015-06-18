require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test

  attr_reader :engine

  def setup
    @engine ||= SalesEngine.new
  end

  def test_it_exists
    assert engine
  end

  def test_it_loads_customer_dependencies_on_startup
    expected_customer = engine.customer_rows
    assert expected_customer, engine
  end

  def test_it_loads_merchant_dependencies_on_startup
    expected_merchant = engine.merchant_rows
    assert expected_merchant, engine
  end

  def test_it_loads_invoice_dependencies_on_startup
    expected_invoice = engine.invoice_rows
    assert expected_invoice, engine
  end

  def test_it_loads_invoice_item_dependencies_on_startup
    expected_invoice_item = engine.invoice_items_rows
    assert expected_invoice_item, engine
  end

  def test_it_loads_item_dependencies_on_startup
    expected_item = engine.item_rows
    assert expected_item, engine
  end

  def test_it_loads_transaction_dependencies_on_startup
    expected_transaction = engine.transaction_rows
    assert expected_transaction, engine
  end

  def test_it_returns_the_first_customer_in_the_repo
    expected = "Joey"
    assert_equal expected, engine.customer_rows.first[:first_name]
  end

  def test_it_returns_the_first_invoice_in_the_row
    expected = "shipped"
    assert_equal expected, engine.invoice_rows.first[:status]
  end

  def test_it_returns_the_first_credit_card_number
    expected = "4654405418249632"
    assert_equal expected, engine.transaction_rows.first[:credit_card_number]
  end

  def test_it_can_access_all_instances_in_a_repo
    expected = File.foreach("./data/invoices.csv").inject(0) { |c, line| c+1 }
    assert_equal expected, engine.invoice_rows.count + 1
  end

end
