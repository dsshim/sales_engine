require_relative 'invoice_repository'

class Invoice

  attr_accessor :created_at,
                :updated_at,
                :merchant_id,
                :customer_id,
                :id,
                :status,
                :repository

  def initialize(row, repo)
    @repository = repo
    @id = row[:id].to_i
    @customer_id = row[:customer_id].to_i
    @merchant_id = row[:merchant_id].to_i
    @status = row[:status]
    @created_at = row[:created_at]
    @updated_at = row[:updated_at]
  end

  def transactions
    repository.find_invoices_by_invoice_id(id)
  end

  def invoice_items
    repository.find_items_by_invoice_id_thru_invoice_items(id)
  end

 def items
    invoice_id = find_invoices_by_id.map(&:id).join.to_i
    repository.find_invoice_items_by_id(invoice_id)
  end

  def find_invoices_by_id
    repository.find_invoices_by_id(id) # invoice id 1002
  end

  def customers
    repository.find_invoices_by_customer_id(id)
  end

  def merchants
    repository.find_merchant_invoices_by_id(id)
  end
end
