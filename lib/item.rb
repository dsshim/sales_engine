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
    @id = row[:id].to_i
    @name = row[:name]
    @description = row[:description]
    @unit_price = row[:unit_price].to_i
    @merchant_id = row[:merchant_id].to_i
    @created_at = row[:created_at]
    @updated_at = row[:updated_at]
  end

  def invoice_items
    repository.find_items_by_id(id)

    #call all invoice items by id
    #map through invoice items and find item
  end

  def merchants
    repository.find_merchants_by_id(id)
  end

end

