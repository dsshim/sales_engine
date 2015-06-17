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
end
