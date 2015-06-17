require_relative 'transaction_repository'

class Transaction


  attr_reader :created_at, :credit_card_number, :updated_at, :result, :id, :invoice_id, :credit_card_expiration_date, :repository

  def initialize(row, repo)
    @repository = repo
    @id = row[:id]
    @invoice_id = row[:invoice_id]
    @credit_card_number = row[:credit_card_number]
    @credit_card_expiration_date = row[:credit_card_expiration_date]
    @result = row[:result]
    @created_at = row[:created_at]
    @updated_at = row[:updated_at]
  end
end
