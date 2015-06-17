require_relative 'merchant_repository'

class Merchant

  attr_reader :id,
              :name,
              :created_at,
              :updated_at,
              :repository


  def initialize(row, repo)
    @repository = repo
    @id = row[:id]
    @name = row[:name]
    @created_at = row[:created_at]
    @updated_at = row[:updated_at]
  end

  def merchant_items(id)
    repository.find_items_by_merchant_id(id)
  end
end

# items returns a collection of Item instances associated with that merchant for the products they sell





# invoices returns a collection of Invoice instances associated with that merchant from their known orders
