require 'minitest/autorun'
require 'minitest/pride'
require './lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test

  def test_it_exists
    assert CustomerRepository.new
  end

  def test_it_has_access_to_the_customers_loaded_in_sales_engine
    customer_repo = CustomerRepository.new

    assert customer_repo.engine
  end

end
