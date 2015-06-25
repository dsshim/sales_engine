require_relative 'customer_repository'

class Customer

  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at,
              :repository,
              :invoice,
              :transactions,
              :successful_transactions,
              :find_favorite_merchant

  def initialize(row, repo)
    @repository = repo
    @id = row[:id].to_i
    @first_name = row[:first_name]
    @last_name = row[:last_name]
    @created_at = row[:created_at]
    @updated_at = row[:updated_at]
  end

  def invoices
    @invoices ||= repository.find_invoices_by_id(id)
  end

  def transactions
    invoice_ids = find_invoices_by_invoice_id.map(&:id)
    @transactions ||= repository
      .find_transactions_by_invoice_ids(invoice_ids).flatten
  end

  def successful_transactions
    @successful_transactions ||= transactions
      .select { |transaction| transaction.successful? }
  end

  def favorite_merchant
    @find_favorite_merchant ||= find_favorite_merchant
  end

  def find_customer_id
    repository.find_by_id(id).id
  end

  def find_invoices_by_invoice_id
    repository.find_invoices_by_id(id)
  end

  private

  def find_favorite_merchant
    invoice_id = successful_transactions.map(&:invoice_id)
    invoices = repository.find_invoices_by_invoice_id(invoice_id)
    groups = invoices.group_by {|invoice| invoice.merchant_id }
    merchant_id = groups.max_by {|x| groups.count(x) }.first
    repository.find_merchant_by_id(merchant_id)[0]
  end
end
