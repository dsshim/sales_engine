require_relative 'test_helper.rb'
require './lib/merchant_repository'
require 'csv'


class MerchantRepositoryTest < Minitest::Test

  attr_reader :sales_engine,
              :merchant_repository,
              :rows

  def setup
    @rows = CSV.open "./data/fixtures/merchants_test.csv", headers: true, header_converters: :symbol
    @merchant_repository ||= MerchantRepository.new(rows, sales_engine)
    @sales_engine = SalesEngine.new(rows)
  end

  def test_it_loads_data_on_initialize
    assert merchant_repository
  end

  def test_it_instantiates_the_merchants_when_initiliazed
    assert_equal 20, merchant_repository.merchants.count
  end

  def test_it_has_access_to_the_first_merchant
    assert_equal 'Schroeder-Jerde', merchant_repository.merchants.first.name
  end

  def test_it_has_access_to_the_second_merchant
    assert_equal 'Klein, Rempel and Jones', merchant_repository.merchants[1].name
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
    assert_equal "Tillman Group", merchant_repository.find_by_name("Tillman Group").name
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
    assert_equal 11, merchant_repository.find_all_by_date_updated("2012-03-27 14:54:00 UTC").count
  end

  def test_it_returns_top_merchant_instances_ranked_by_total_revenue
    expected = sales_engine.merchant_repository
                   .most_revenue(1).map { |merchant| merchant.name }.flatten

    assert_equal "Dicki-Bednar", expected[0]
  end

  def test_it_returns_top_merchant_instances_ranked_by_total_items_sold
    expected = sales_engine.merchant_repository
                   .most_items(2).first.name

    assert_equal "Kassulke, O'Hara and Quitzon", expected
  end

  def test_it_returns_total_revenue_for_the_date_all_merchants
    expected = sales_engine.merchant_repository
                   .revenue(Date.parse "Tue, 20 Mar 2012")

    assert_equal BigDecimal.new("2549722.91"), expected
  end
end
