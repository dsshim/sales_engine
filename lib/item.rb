require_relative 'item_repository'
class Item

  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at,
              :repository

  def initialize(row, repo)
    @repository = repo
    @id = row[:id]
    @name = row[:name]
    @description = row[:description]
    @unit_price = row[:unit_price]
    @merchant_id = row[:merchant_id]
    @created_at = row[:created_at]
    @updated_at = row[:updated_at]
  end

  def invoice_items
    repository.find_items_by_id(id)
  end

  def merchants
    repository.find_merchants_by_id(id)
  end

end

