require_relative 'sales_engine'
# require_relative 'customer_parser'
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

  def find_by(attribute, value)
    customers.detect { |customer| customer.send(attribute) == value }
  end

  def find_all_by(attribute, value)
    customers.select { |customer| customer.send(attribute) == value }
  end
end

