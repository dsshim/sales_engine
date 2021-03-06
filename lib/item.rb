require_relative 'item_repository'
class Item

  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at,
              :repository,
              :invoice_items,
              :revenue,
              :quantity_sold

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
    @invoice_items ||= repository.find_items_by_id(id)
  end

  def revenue
    @revenue ||= invoice_items.map { |ii| ii.value }
      .inject(0) { |acc, value| acc + value }
  end

  def quantity_sold
    @quantity_sold ||= invoice_items.map { |ii| ii.quantity_sold }
      .inject(0) { |acc, value| acc + value }
  end

  def merchant
    repository.find_merchants_by_id(get_merchant_id)[0]
  end

  def get_merchant_id
    repository.find_by_id(id).merchant_id
  end

  def best_day
    get_best_day
  end

  private

  def get_best_day
    dates = invoice_items.map { |ii| ii.invoice.created_at }
    revenue = invoice_items.map do |ii|
      ii.quantity * ii.unit_price
    end
    revenue_by_date = revenue.zip(dates).sort
    max_revenue = revenue_by_date.pop
    Date.parse(max_revenue[1])
  end
end

