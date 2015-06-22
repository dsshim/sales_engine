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
    find_transactions_by_invoice_id
    #returns an array of transactions connected to that customer
      # find customer by id in the repo √
      # find all invoices associated with that customer id √
      # find all transactions associated with that invoice  id
  end

  def find_customer_id
    repository.find_by_id(id).id
  end

  def find_invoices_by_customer_id
    id = find_customer_id
    repository.find_invoices_by_customer_id(id)
  end

  def find_transactions_by_invoice_id
    invoice_id = repository.find_invoices_by_customer_id(id)
  end
end
