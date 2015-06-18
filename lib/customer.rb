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
end
