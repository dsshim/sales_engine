require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test


attr_reader :rows, :sales_engine, :invoice_repository

def setup
  rows = CSV.open "./data/fixtures/invoices_test.csv", headers: true, header_converters: :symbol
  @invoice_repository = InvoiceRepository.new(rows, sales_engine)
  @sales_engine = sales_engine
end

def test_it_loads_on_initialize
  assert invoice_repository
  assert invoice_repository.invoices
end

def test_it_creates_the_invoices_by_taking_data_from_the_repo
  assert_equal 50, invoice_repository.invoices.count
end

def test_it_has_access_to_the_data
  first_merchant = "26"
  assert_equal first_merchant, invoice_repository.invoices.first.merchant_id
end

def test_it_finds_all_invoices
  assert_equal invoice_repository.invoices, invoice_repository.all
end

def test_it_returns_a_random_invoice
  first_merchant = invoice_repository.random.merchant_id
  second_merchant = invoice_repository.random.merchant_id

  refute_equal first_merchant, second_merchant
end

def test_it_finds_invoices_by_id
  assert_equal "1", invoice_repository.find_by_id("1").id
end

def test_it_finds_invoices_by_customer_id
  assert_equal "1", invoice_repository.find_by_customer_id("1").customer_id
end

def test_it_finds_invoices_by_merchant_id
  assert_equal "33", invoice_repository.find_by_merchant_id("33").merchant_id
end

def test_it_finds_invoices_by_status
  assert_equal "shipped", invoice_repository.find_by_status("shipped").status
end

def test_it_finds_invoices_by_date_created
  assert_equal "2012-03-26 07:54:10 UTC", invoice_repository.find_by_date_created("2012-03-26 07:54:10 UTC").created_at
end

def test_it_finds_invoices_by_update_date
  assert_equal "2012-03-10 10:54:10 UTC", invoice_repository.find_by_date_updated("2012-03-10 10:54:10 UTC").updated_at
end

def test_it_finds_all_invoices_by_customer_id
  assert_equal 8, invoice_repository.find_all_by_customer_id("1").count
end

def test_it_finds_all_invoices_by_merchant_id
  assert_equal 1, invoice_repository.find_all_by_merchant_id("75").count
end

def test_it_finds_all_invoices_by_status
  assert_equal 50, invoice_repository.find_all_by_status("shipped").count
end

def test_it_finds_all_invoices_by_date_created
  assert_equal 1, invoice_repository.find_all_by_date_created("2012-03-13 16:54:10 UTC").count
end

def test_it_finds_all_invoices_by_date_updated
  assert_equal 1, invoice_repository.find_all_by_date_updated("2012-03-16 10:54:11 UTC").count
end
end
