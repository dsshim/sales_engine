require_relative 'sales_engine'
require_relative 'invoice'

class InvoiceRepository


  attr_accessor :sales_engine, :rows, :invoices

  def initialize(rows, sales_engine)
    @rows = rows
    @sales_engine = sales_engine
    @invoices = []
    invoice_parser
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end

  def invoice_parser
    @invoices = rows.map{|row| Invoice.new(row,self)}
  end

  def all
    invoices
  end

  def random
    invoices.sample
  end

  def find_invoices_by_invoice_id(id)
    sales_engine.find_invoices_by_invoice_id(id)
  end

  def find_invoices_by_id(id)
    sales_engine.find_invoices_by_id(id)
  end

  def find_items_by_invoice_item(id)
    sales_engine.find_invoice_items_by_id(id)
  end

  def find_invoices_by_customer_id(id)
    sales_engine.find_invoices_by_customer_id(id)
  end

  def find_invoice_items_by_id(id)
    sales_engine.find_invoice_items_by_id(id)
  end

  def find_all_items_by_item_id(item_id)
    sales_engine.find_items_by_item_id(item_id)
  end

  def find_merchant_invoices_by_id(id)
    sales_engine.find_merchant_invoices_by_id(id)
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

  def find_all_by_date_updated(updated_at)
    invoices.select { |invoice| invoice.updated_at == updated_at }
  end

end
