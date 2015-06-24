require_relative 'sales_engine'
require_relative 'invoice'

class InvoiceRepository


  attr_accessor :engine, :rows, :invoices

  def initialize(rows, engine)
    @rows = rows
    @engine = engine
    @invoices = []
    invoice_parser
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end

  def invoice_parser
    @invoices = rows.map{|row| Invoice.new(row, self)}
  end

  def create(data)
    row = {
      id:          invoices.last.id + 1,
      customer_id: data[:customer].id,
      merchant_id: data[:merchant].id,
      status:      data[:status],
      created_at:  "#{Date.new}",
      updated_at:  "#{Date.new}",
    }
    invoices << new_invoice = Invoice.new(row, self)
    invoice_items = data[:items].map do |item|
      quantity = 1
      unit_price = item.unit_price
      id = item.id
      engine.create_invoice_items(id, row[:id].to_i, quantity, unit_price)
    end
    new_invoice
  end

  def create_transaction(data, id)
    engine.create_transaction(data, id)
  end

  def all
    invoices
  end

  def random
    invoices.sample
  end

  def find_invoices_by_invoice_id(id)
    engine.find_invoices_by_invoice_id(id)
  end

  def find_invoices_by_id(id)
    engine.find_invoices_by_id(id)
  end

  def find_items_by_invoice_item(id)
    engine.find_invoice_items_by_id(id)
  end

  def find_items_by_item_id(item_ids)
    engine.find_all_by_item_id(item_ids)
  end

  def find_customer_by_customer_id(customer_id)
    engine.find_customer_by_id(customer_id)
  end

  def find_invoices_by_customer_id(id)
    engine.find_invoices_by_customer_id(id)
  end

  def find_invoice_items_by_id(id)
    engine.find_invoice_items_by_id(id)
  end

  def find_all_items_by_item_id(item_id)
    engine.find_items_by_item_id(item_id)
  end

  def find_merchant_invoices_by_id(id) #change chain
    engine.find_merchants_by_id(id)
  end

  def find_by_id(id)
    invoices.detect { |invoice| invoice.id == id }
  end

  def find_by_customer_id(customer_id)
    invoices.detect { |invoice| invoice.customer_id == customer_id }
  end

  def find_by_merchant_id(merchant_id)
    invoices.detect { |invoice| invoice.merchant_id == merchant_id }
  end

  def find_by_status(status)
    invoices.detect { |invoice| invoice.status == status }
  end

  def find_by_date_created(created_at)
    invoices.detect { |invoice| invoice.created_at == created_at }
  end

  def find_by_date_updated(updated_at)
    invoices.detect { |invoice| invoice.updated_at == updated_at }
  end

  def find_all_by_id(id)
    invoices.select { |invoice| invoice.id == id }
  end

  def find_multiple_by_id(id)
    id.map {|id| find_by_id(id) }
  end

  def find_all_by_customer_id(customer_id)
    invoices.select { |invoice| invoice.customer_id == customer_id }
  end

  def find_all_by_merchant_id(merchant_id)
    invoices.select { |invoice| invoice.merchant_id == merchant_id }
  end

  def find_all_by_status(status)
    invoices.select {|invoice| invoice.status == status}
  end

  def find_all_by_date_created(created_at)
    invoices.select { |invoice| invoice.created_at == created_at }
  end

  def find_all_by_date_created_string_input(created_at)
    invoices.select { |invoice| invoice.created_at.to_s.include?(created_at) }
  end

  def find_all_by_date_updated(updated_at)
    invoices.select { |invoice| invoice.updated_at == updated_at }
  end

end
