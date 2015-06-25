require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant_repository'
require 'csv'

class MerchantRepositoryTest < Minitest::Test

  attr_reader :sales_engine,
              :merchant_repository

  def setup
    rows = CSV.open "./data/fixtures/merchants_test.csv", headers: true, header_converters: :symbol
    @merchant_repository = MerchantRepository.new(rows, sales_engine)
    @sales_engine = sales_engine
  end

  def test_it_loads_data_on_initialize
    assert merchant_repository
  end

  def test_it_instantiates_the_merchants_when_initiliazed
    assert_equal 39, merchant_repository.merchants.count
  end

  def test_it_has_access_to_the_first_merchant
    assert_equal 'Schroeder-Jerde', merchant_repository.merchants.first.name
  end

  def test_it_has_access_to_the_second_merchant
    assert_equal 'Klein, Rempel and Jones', merchant_repository.merchants[1].name
  end

  def test_it_finds_and_returns_all_customers
    assert_equal merchant_repository.merchants, merchant_repository.all
  end

  def test_it_finds_a_random_merchant
    first_merchant = merchant_repository.random
    second_merchant = merchant_repository.random

    refute_equal first_merchant, second_merchant
  end

  def test_it_finds_merchants_by_id
    assert_equal 10, merchant_repository.find_by_id(10).id
  end

  def test_it_finds_merchants_by_name
    assert_equal "Leffler, Rice and Leuschke", merchant_repository.find_by_name("Leffler, Rice and Leuschke").name
  end

  def test_it_finds_merchants_by_date_created
    assert_equal "2012-03-27 14:53:59 UTC", merchant_repository.find_by_date_created("2012-03-27 14:53:59 UTC").created_at
  end

  def test_it_finds_merchants_by_date_updated
    assert_equal "2012-03-27 14:54:00 UTC", merchant_repository.find_by_date_updated("2012-03-27 14:54:00 UTC").updated_at
  end

  def test_it_finds_all_by_name
    assert_equal 2, merchant_repository.find_all_by_name("Williamson Group").count
  end

  def test_it_finds_all_by_date_created
    assert_equal 9, merchant_repository.find_all_by_date_created("2012-03-27 14:53:59 UTC").count
  end

  def test_it_finds_all_by_date_updated
    assert_equal 12, merchant_repository.find_all_by_date_updated("2012-03-27 14:54:00 UTC").count
  end
end
