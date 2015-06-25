require_relative 'test_helper.rb'
require './lib/transaction_repository'

class TransactionRepositoryTest < Minitest::Test

  attr_reader :rows, :sales_engine, :transaction_repository

  def setup
    @rows = CSV.open "./data/fixtures/transactions_test.csv", headers: true, header_converters: :symbol
    @transaction_repository = TransactionRepository.new(rows, sales_engine)
    @sales_engine = sales_engine
  end

  def test_it_loads_on_initialize
    assert transaction_repository
    assert transaction_repository.transactions
  end

  def test_it_creates_transactions_by_taking_data_from_the_repo
    assert_equal 50, transaction_repository.transactions.count
  end

  def test_it_has_access_to_the_data
    first_created_at_date = "2012-03-27 14:54:09 UTC"
    assert_equal first_created_at_date, transaction_repository.transactions.first.created_at
  end

  def test_it_finds_all_customers
    assert_equal transaction_repository.transactions, transaction_repository.all
  end

  def test_it_returns_a_random_customer
    first_invoice_id = transaction_repository.random.invoice_id
    second_invoice_id = transaction_repository.random.invoice_id

    refute_equal first_invoice_id, second_invoice_id
  end

  def test_it_finds_transactions_by_id
    assert_equal 5, transaction_repository.find_by_id(5).id
  end

  def test_it_finds_transactions_by_invoice_id
    assert_equal 5, transaction_repository.find_by_invoice_id(5).invoice_id
  end

  def test_it_finds_transactions_by_credit_card_number
    assert_equal "4738848761455352", transaction_repository.find_by_credit_card_number("4738848761455352").credit_card_number
  end

  def test_it_finds_transactions_by_expiration_date
    assert_equal "No Exp Date", transaction_repository.find_by_expiration_date("2021-07-31")
  end

  def test_it_finds_transactions_by_result
    assert_equal "success", transaction_repository.find_by_result("success").result
  end

  def test_it_finds_transactions_by_date_created
    assert_equal "2012-03-27 14:54:10 UTC", transaction_repository.find_by_date_created("2012-03-27 14:54:10 UTC").created_at
  end

  def test_it_finds_transactions_by_update_date
    assert_equal "2012-03-27 14:54:11 UTC", transaction_repository.find_by_date_updated("2012-03-27 14:54:11 UTC").updated_at
  end

  def test_it_finds_all_transactions_by_credit_card_number
    assert_equal 1, transaction_repository.find_all_by_credit_card_number("4800749911485986").count
  end

  def test_it_finds_all_transactions_by_result
    assert_equal 41, transaction_repository.find_all_by_result("success").count
    assert_equal 9, transaction_repository.find_all_by_result("failed").count
  end

  def test_it_finds_all_transactions_by_date_created
    assert_equal 20, transaction_repository.find_all_by_date_created("2012-03-27 14:54:10 UTC").count
  end

  def test_it_finds_all_transactions_by_date_updated
    assert_equal 28, transaction_repository.find_all_by_date_updated("2012-03-27 14:54:11 UTC").count
  end
end
