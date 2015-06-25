require_relative 'invoice_item_repository'

class InvoiceItem


  attr_reader :created_at,
              :unit_price,
              :updated_at,
              :id,
              :quantity,
              :item_id,
              :repository,
              :invoice_id,
              :invoice,
              :item,
              :quantity_sold,
              :value

  def initialize(row, repo)
    @repository    = repo
    @id            = row[:id].to_i
    @item_id       = row[:item_id].to_i
    @invoice_id    = row[:invoice_id].to_i
    @quantity      = row[:quantity].to_i
    @unit_price    = row[:unit_price].to_i
    @created_at    = row[:created_at]
    @updated_at    = row[:updated_at]
  end

  def invoice
    @invoice ||= repository.find_invoice_by_id(invoice_id)
  end

  def item
    @item ||= repository.find_item_by_id(item_id)
  end

  def create_invoice_items(invoice_id, quantity, unit_price)
    data
    invoice_items << InvoiceItem.new(data, self)
  end

  def value
   @value ||= invoice.successful? ? unit_price * quantity : 0
  end

  def quantity_sold
    @quanity_sold ||= invoice.successful? ? quantity : 0
  end

  private

  def data
    data = {
      id:          invoice_items.last.id + 1,
      invoice_id:  invoice_id.to_i,
      quantity:    quantity,
      unit_price:  unit_price,
      created_at:  "#{Date.new}",
      updated_at:  "#{Date.new}"
    }
  end
end
