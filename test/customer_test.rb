require 'minitest/autorun'
require 'minitest/pride'
require './lib/customer'

class CustomerTest < Minitest::Test

 attr_reader :data

  def setup
    @data = {
      id: 1,
      first_name: "Joey",
      last_name: "Ondricka",
      created_at: "2012-03-27 14:53:59 UTC",
      updated_at: "2012-03-27 14:53:59 UTC"
    }
  end

  def test_it_receives_data_at_initialize
    customer = Customer.new(data, nil)
    assert_equal 1, customer.id
    assert_equal "Joey", customer.first_name
  end

  def test_it_returns_a_collection_of_invoices
    repository = Minitest::Mock.new
    customer = Customer.new(data, repository)
    repository.expect(:find_invoices_by_id, nil, [1])
    customer.invoices
    repository.verify
  end
end
