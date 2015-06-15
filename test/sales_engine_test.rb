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

  def test_it_returns_the_first_customer_in_the_repo
    engine = SalesEngine.new
    expected = "Joey"

    assert_equal expected, engine.customer_repository.first[:first_name]
  end

  def test_it_returns_the_first_invoice_in_the_repo
    engine = SalesEngine.new
    expected = "shipped"

    assert_equal expected, engine.invoice_repository.first[:status]
  end

  def test_it_returns_the_first_credit_card_number
    engine = SalesEngine.new
    expected = "4654405418249632"

    assert_equal expected, engine.transaction_repository.first[:credit_card_number]
  end

  def test_it_has_access_to_list_and_search_module
    assert ListAndSearch
  end

  def test_it_can_access_all_instances_in_a_repo
    engine = SalesEngine.new
    expected = File.foreach("./data/invoices.csv").inject(0) {|c, line|c+1}

    assert_equal expected, engine.invoice_repository.readlines.size + 1
  end

end
