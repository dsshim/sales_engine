require_relative 'sales_engine'
require_relative 'invoice_item'

class InvoiceItemRepository

  attr_reader :sales_engine, :invoice_items
  attr_accessor :rows

  def initialize(rows, sales_engine)
    @sales_engine = sales_engine
    @rows = rows
    @invoice_items = []
    invoice_item_parser
  end

  def invoice_item_parser
    @invoice_items = rows.map { |row| InvoiceItem.new(row, self) }
  end

  def all
    invoice_items
  end

  def random
    invoice_items.sample
  end

  def find_by_id(id)
    invoice_items.detect { |invoice_item| invoice_item.id == id }
  end

  def find_by_item_id(item_id)
    invoice_items.detect { |invoice_item| invoice_item.item_id == item_id }
  end

  def find_by_invoice_id(invoice_id)
    invoice_items.detect { |invoice_item| invoice_item.invoice_id == invoice_id }
  end

  def find_by_quantity(quantity)
    invoice_items.detect { |invoice_item| invoice_item.quantity == quantity }
  end

  def find_by_unit_price(unit_price)
    invoice_items.detect { |invoice_item| invoice_item.unit_price == unit_price }
  end

  def find_by_date_created(created_at)
    invoice_items.detect { |invoice_item| invoice_item.created_at == created_at }
  end

  def find_by_date_updated(updated_at)
    invoice_items.detect { |invoice_item| invoice_item.updated_at == updated_at }
  end

  def find_all_by_item_id(item_id)
    invoice_items.select { |invoice_item| invoice_item.item_id == item_id }
  end

  def find_all_by_invoice_id(invoice_id)
    invoice_items.select { |invoice_item| invoice_item.invoice_id == invoice_id }
  end

  def find_all_by_quantity(quantity)
    invoice_items.select { |invoice_item| invoice_item.quantity == quantity }
  end

  def find_all_by_unit_price(unit_price)
    invoice_items.select { |invoice_item| invoice_item.unit_price == unit_price }
  end

  def find_all_by_date_created(created_at)
    invoice_items.select { |invoice_item| invoice_item.created_at == created_at }
  end

  def find_all_by_date_updated(updated_at)
    invoice_items.select { |invoice_item| invoice_item.updated_at == updated_at }
  end
end


