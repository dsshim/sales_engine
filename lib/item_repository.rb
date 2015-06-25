require_relative 'sales_engine'
require_relative 'item'
require 'bigdecimal'

class ItemRepository

  attr_accessor :rows,
                :items,
                :engine,
                :most_items,
                :most_revenue

  def initialize(rows, engine)
    @rows = rows
    @engine = engine
    @items = item_parser
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end

  def item_parser
    rows.map { |row| Item.new(row, self) }
  end

  def most_revenue(quantity)
    @most_revenue ||= items.max_by(quantity){|i| i.revenue}
  end

  def most_items(quantity)
    @most_items ||= items.max_by(quantity){|i| i.quantity_sold}
  end

  def all
    items
  end

  def random
    items.sample
  end

  def get_invoice_items
    engine.get_invoice_items
  end

  def find_invoices_by_invoice_id(invoice_id)
    engine.find_invoices_by_id(invoice_id)
  end

  def find_items_by_id(id)
    engine.find_items_by_id(id)
  end

  def find_merchants_by_id(id)
    engine.find_merchants_by_id(id)
  end

  def find_transactions_by_id(id)
    engine.find_invoices_by_invoice_id(id)
  end

  def find_by_id(id)
    items.detect { |item| item.id == id }
  end

  def find_multiple_by_id(ids)
    ids.map { |id| find_by_id(id) }
  end

  def find_by_name(name)
    items.detect { |item| item.name == name }
  end

  def find_by_description(description)
    items.detect { |item| item.description == description }
  end

  def find_by_unit_price(unit_price)
    items.detect { |item| item.unit_price.to_f / 100 == unit_price.to_f }
  end

  def find_by_merchant_id(merchant_id)
    items.detect { |item| item.merchant_id == merchant_id }
  end

  def find_by_date_created(created_at)
    items.detect { |item| item.created_at == created_at }
  end

  def find_by_date_updated(updated_at)
    items.detect { |item| item.updated_at == updated_at }
  end

  def find_all_by_id(id)
    items.select { |item| item.id == id }
  end

  def find_all_by_name(name)
    items.select { |item| item.name == name }
  end

  def find_all_by_description(description)
    items.select { |item| item.description == description }
  end

  def find_all_by_unit_price(unit_price)
    items.select { |item| item.unit_price == unit_price }
  end

  def find_all_by_merchant_id(merchant_id)
    items.select { |item| item.merchant_id == merchant_id }
  end

  def find_all_by_date_created(created_at)
    items.select { |item| item.created_at == created_at }
  end

  def find_all_by_date_updated(updated_at)
    items.select { |item| item.updated_at == updated_at }
  end
end
