require_relative 'sales_engine'
require_relative 'invoice_item'

class InvoiceItemRepository

  attr_reader :engine
  attr_accessor :rows, :invoice_items

  def initialize(rows, engine)
    @engine = engine
    @rows = rows
    @invoice_items = invoice_item_parser
  end

  def inspect
    "#<#{self.class} #{@invoice_items.size} rows>"
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

  def find_invoice_items_by_invoice_id_from_ii(id)
    engine.find_invoices_by_id(id) #change chain down
  end

  def find_invoice_items_by_item_id(id)
    engine.find_items_by_item_id(id)
  end

  def find_item_by_item_id(item_id)
    engine.find_item_by_item_id(item_id)
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

  def find_multiple_by_invoice_id(invoice_ids)
    invoice_ids.map { |invoice_id| find_by_invoice_id(invoice_id) }
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


