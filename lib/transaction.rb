require_relative 'transaction_repository'

class Transaction


  attr_reader :created_at,
              :credit_card_number,
              :updated_at,
              :result,
              :id,
              :invoice_id,
              :credit_card_expiration_date,
              :repository,
              :invoice

  def initialize(row, repo)
    @repository = repo
    @id = row[:id].to_i
    @invoice_id = row[:invoice_id].to_i
    @credit_card_number = row[:credit_card_number]
    @credit_card_expiration_date = row[:credit_card_expiration_date]
    @result = row[:result]
    @created_at = row[:created_at]
    @updated_at = row[:updated_at]
  end

  def invoice(invoice_id = get_invoice_id)
    @invoice ||= repository.find_invoices_by_invoice_id(invoice_id)[0]
  end

  def get_invoice_id
    repository.find_by_id(id).invoice_id
  end

  def successful_result_codes
    ['success']
  end

  def successful?
    successful_result_codes.include?(result)
  end
end
