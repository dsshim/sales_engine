require_relative 'item_repository'
require 'pry'
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
  end

  def merchant
    repository.find_merchants_by_id(get_merchant_id)[0]
  end

  def get_merchant_id
    repository.find_by_id(id).merchant_id
  end

  def best_day
    get_invoice_ids_from_invoice_items
  end


  def get_invoice_ids_from_invoice_items
    invoice_id = invoice_items.map(&:invoice_id)
    invoices = invoice_id.map{|id| repository.find_invoices_by_invoice_id(id)}
    dates = invoices.flatten.map(&:created_at)
    quantity = invoice_items.map(&:quantity)
    price = invoice_items.map(&:unit_price)
    quan_price_array = price.zip(quantity)
    revenue = quan_price_array.map do |price,quantity|
      price*quantity
    end
    revenue_by_date = revenue.zip(dates).sort
    max_revenue = revenue_by_date.pop
    Date.parse(max_revenue[1])
  end
end

