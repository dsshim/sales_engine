require_relative 'invoice_item_repository'

class InvoiceItem


  attr_reader :created_at, :unit_price, :updated_at, :id, :quantity, :item_id, :repository, :invoice_id

  def initialize(row, repo)
    @repository = repo
    @id = row[:id].to_i
    @item_id = row[:item_id].to_i
    @invoice_id = row[:invoice_id].to_i
    @quantity = row[:quantity].to_i
    @unit_price = row[:unit_price].to_i
    @created_at = row[:created_at]
    @updated_at = row[:updated_at]
  end

  def invoices
    repository.find_invoice_items_by_invoice_id(id)
  end

  def items
    repository.find_invoice_items_by_item_id(id)
  end

end
