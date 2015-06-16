require 'minitest/autorun'
require 'minitest/pride'
require './lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test

  attr_reader :rows, :sales_engine, :customer_repository, :customers

  def setup
    @rows = CSV.open "./data/fixtures/customers_test.csv", headers: true, header_converters: :symbol
    @customer_repository = CustomerRepository.new(rows, sales_engine)
  end

  def test_it_loads_on_initialize
    assert customer_repository
    assert customer_repository.customers
  end

  def test_it_creates_the_customers_by_taking_data_from_the_repo
    assert_equal 10, customer_repository.customers.count
  end

  def test_it_has_access_to_the_data
    first_customer = "Joey"
    assert_equal first_customer, customer_repository.customers.first.first_name
  end

  def test_it_finds_all_customers
    assert_equal customer_repository.customers, customer_repository.all
  end

  def test_it_returns_a_random_customer
    first_customer = customer_repository.random.first_name
    second_customer = customer_repository.random.first_name

    refute_equal first_customer, second_customer
  end

end
