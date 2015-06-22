require_relative 'customer_repository'
require 'pry'
class Customer

  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at,
              :repository

  def initialize(row, repo)
    @repository = repo
    @id = row[:id].to_i
    @first_name = row[:first_name]
    @last_name = row[:last_name]
    @created_at = row[:created_at]
    @updated_at = row[:updated_at]
  end

  def invoices
    repository.find_invoices_by_id(id)
  end

  def transactions
    invoice_ids = find_invoices_by_invoice_id.map(&:id)
    repository.find_transactions_by_invoice_ids(invoice_ids).flatten
  end

  def successful_transactions
    transactions.select { |transaction| transaction.result == 'success' }
  end

  def favorite_merchant
    invoice_id = successful_transactions.map(&:invoice_id)
    invoices = repository.find_invoices_by_invoice_id(invoice_id)
    groups = invoices.group_by {|invoice| invoice.merchant_id }
    most_frequent_m_id = groups.max_by {|x| groups.count(x) }.first
    repository.find_merchant_by_id(most_frequent_m_id)[0]
    # return all invoices of succesful transactions
    # then, group by merchant id and find the most frequent
    # take that merchant id and look up the merchant
  end

  #favorite_merchant returns an instance of Merchant where the customer has conducted the most successful transactions

  def find_customer_id
    repository.find_by_id(id).id
  end

  def find_invoices_by_customer_id
    id = find_customer_id
    repository.find_invoices_by_customer_id(id)
  end

  def find_invoices_by_invoice_id
    repository.find_invoices_by_customer_id(id)
  end
end
