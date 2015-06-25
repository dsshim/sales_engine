require_relative 'invoice_repository'
class Invoice

  attr_accessor :created_at,
                :updated_at,
                :merchant_id,
                :customer_id,
                :id,
                :status,
                :repository,
                :transactions,
                :invoice_items,
                :items,
                :transactions,
                :successful_transactions

  def initialize(row, repo)
    @repository     = repo
    @id             = row[:id].to_i
    @customer_id    = row[:customer_id].to_i
    @merchant_id    = row[:merchant_id].to_i
    @status         = row[:status]
    @created_at     = row[:created_at]
    @updated_at     = row[:updated_at]
  end

  def transactions
    repository.find_invoices_by_invoice_id(id)
  end

  def invoice_items
    @invoice_items ||= repository.find_items_by_invoice_item(id)
  end

  def items
    @items ||= invoice_items.map { |invoice_item| invoice_item.item }
  end

  def successful?
    @successful_transactions ||= transactions.any? {|t| t.successful? }
  end

  def charge(data)
    repository.create_transaction(data, id)
  end

  def find_items_by_invoice_item_id
    repository.find_items_by_item_id(id)
  end

  def customer
    repository.find_customer_by_customer_id(customer_id)
  end

  def merchant
    repository.find_merchant_invoices_by_id(id)
  end
end
