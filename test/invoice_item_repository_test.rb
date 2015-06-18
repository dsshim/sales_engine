require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test

  attr_reader :rows, :sales_engine, :invoice_item_repository

  def setup
    rows = CSV.open "./data/fixtures/invoice_items_test.csv", headers: true, header_converters: :symbol
    @invoice_item_repository = InvoiceItemRepository.new(rows, sales_engine)
    @sales_engine = sales_engine
  end

  def test_it_loads_on_initialize
    assert invoice_item_repository
    assert invoice_item_repository.invoice_items
  end

  def test_it_creates_the_invoice_items_by_taking_data_from_the_repo
    assert_equal 50, invoice_item_repository.invoice_items.count
  end

  def test_it_has_access_to_the_data
    first_item_id = 539
    assert_equal first_item_id, invoice_item_repository.invoice_items.first.item_id
  end

  def test_it_finds_all_invoice_items
    assert_equal invoice_item_repository.invoice_items, invoice_item_repository.all
  end

  def test_it_returns_a_random_item_id
    first_item_id = invoice_item_repository.random.item_id
    second_item_id = invoice_item_repository.random.item_id

    refute_equal first_item_id, second_item_id
  end

  def test_it_finds_invoice_item_by_id
    assert_equal 5, invoice_item_repository.find_by_id(5).id
  end

  def test_it_finds_invoice_item_by_item_id
    assert_equal 523, invoice_item_repository.find_by_item_id(523).item_id
  end

  def test_it_finds_invoice_item_by_invoice_id
    assert_equal 1, invoice_item_repository.find_by_invoice_id(1).invoice_id
  end

  def test_it_finds_invoice_item_by_quantity
    assert_equal 9, invoice_item_repository.find_by_quantity(9).quantity
  end

  def test_it_finds_invoice_item_by_unit_price
    assert_equal 34873, invoice_item_repository.find_by_unit_price(34873).unit_price
  end

  def test_it_finds_invoice_item_by_date_created
    assert_equal "2012-03-27 14:54:09 UTC", invoice_item_repository.find_by_date_created("2012-03-27 14:54:09 UTC").created_at
  end

  def test_it_finds_customers_by_update_date
    assert_equal "2012-03-27 14:54:09 UTC", invoice_item_repository.find_by_date_updated("2012-03-27 14:54:09 UTC").updated_at
  end

  def test_it_finds_all_invoice_items_by_item_id
    assert_equal 3, invoice_item_repository.find_all_by_item_id(1918).count
  end

  def test_it_finds_all_invoice_items_by_invoice_id
    assert_equal 4, invoice_item_repository.find_all_by_invoice_id(2).count
  end

  def test_it_finds_all_invoice_items_by_quantity
    assert_equal 4, invoice_item_repository.find_all_by_quantity(7).count
  end

  def test_it_finds_all_invoice_items_by_unit_price
    assert_equal 2, invoice_item_repository.find_all_by_unit_price(50051).count
  end

  def test_it_finds_all_customers_by_date_created
    assert_equal 15, invoice_item_repository.find_all_by_date_created("2012-03-27 14:54:09 UTC").count
  end

  def test_it_finds_all_customers_by_date_updated
    assert_equal 35, invoice_item_repository.find_all_by_date_updated("2012-03-27 14:54:10 UTC").count
  end
end
