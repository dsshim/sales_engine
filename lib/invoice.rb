require_relative 'invoice_repository'

class Invoice

  attr_reader :created_at, :updated_at, :merchant_id, :customer_id, :id, :status, :repository

  def initialize(row, repo)
    @repository = repo
    @id = row[:id]
    @customer_id = row[:customer_id]
    @merchant_id = row[:merchant_id]
    @status = row[:status]
    @created_at = row[:created_at]
    @updated_at = row[:updated_at]
  end

  def transactions
    repository.find_invoices_by_id(id)
  end

  def invoice_items
    repository.find_invoice_items_by_id(id)
  end

  def items
    repository.find_items_by_invoice_item(id)
  end

  def customers
    repository.find_invoices_by_customer_id(id)
  end

  def merchants
    repository.find_invoices_by_merchant_id(id)
  end
end
