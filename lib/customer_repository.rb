require_relative 'sales_engine'
require_relative 'customer'

class CustomerRepository

  attr_reader :sales_engine, :customers
  attr_accessor :rows

  def initialize(rows, sales_engine)
    @sales_engine = sales_engine
    @rows = rows.read
    @customers = []
    customer_parser
  end

  def customer_parser
    @customers = rows.map { |row| Customer.new(row, self) }
  end

  def all
    customers
  end

  def random
    customers.sample
  end

  def find_by_id(id)
    customers.detect { |customer| customer.id == id }
  end

  def find_by_first_name(first_name)
    customers.detect { |customer| customer.first_name == first_name }
  end

  def find_by_last_name(last_name)
    customers.detect { |customer| customer.last_name == last_name }
  end

  def find_by_date_created(created_at)
    customers.detect { |customer| customer.created_at == created_at }
  end

  def find_by_date_updated(updated_at)
    customers.detect { |customer| customer.updated_at == updated_at }
  end

  def find_all_by_first_name(first_name)
    customers.select { |customer| customer.first_name == first_name }
  end

  def find_all_by_last_name(last_name)
    customers.select { |customer| customer.last_name == last_name }
  end

  def find_all_by_date_created(created_at)
    customers.select { |customer| customer.created_at == created_at }
  end

  def find_all_by_date_updated(updated_at)
    customers.select { |customer| customer.updated_at == updated_at }
  end
end

