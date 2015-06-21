require_relative 'sales_engine'
require_relative 'item'
class ItemRepository

  attr_accessor :rows
  attr_reader   :items

  def initialize(rows, sales_engine)
    @rows = rows
    @sales_engine = sales_engine
    @items = item_parser
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end

  def item_parser
    rows.map { |row| Item.new(row, self) }
  end

  def all
    items
  end

  def random
    items.sample
  end

  def find_items_by_id(id)
    sales_engine.find_items_by_id(id)
  end

  def find_merchants_by_id(id)
    sales_engine.find_merchants_by_id(id)
  end

  def find_by_id(id)
    items.detect { |item| item.id == id }
  end

  def find_each_by_id(ids)
    ids.map { |id| find_by_id(id) }
  end

  def find_by_name(name)
    items.detect { |item| item.name == name }
  end

  def find_by_description(description)
    items.detect { |item| item.description == description }
  end

  def find_by_unit_price(unit_price)
    items.detect { |item| item.unit_price == unit_price }
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
