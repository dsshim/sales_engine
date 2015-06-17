require_relative 'sales_engine'
require_relative 'transaction'

class TransactionRepository


  attr_accessor :sales_engine, :rows, :transactions

  def initialize(rows, sales_engine)
    @rows = rows
    @sales_engine = sales_engine
    @transactions = []
    transaction_parser
  end

  def transaction_parser
    @transactions = rows.map { |row| Transaction.new(row, self) }
  end

  def all
    transactions
  end

  def random
    transactions.sample
  end

  def find_by_id(id)
    transactions.detect { |transaction| transaction.id == id }
  end

  def find_by_invoice_id(invoice_id)
    transactions.detect { |transaction| transaction.invoice_id == invoice_id }
  end

  def find_by_credit_card_number(credit_card_number)
    transactions.detect { |transaction| transaction.credit_card_number == credit_card_number }
  end

  def find_by_expiration_date(credit_card_expiration_date)
    transactions.detect do |transaction|
      if transaction.credit_card_expiration_date.nil?
        return "No Exp Date"
      else
        transaction.credit_card_expiration_date == credit_card_expiration_date
      end
    end
  end

  def find_by_result(result)
    transactions.detect { |transaction| transaction.result == result }
  end

  def find_by_date_created(created_at)
    transactions.detect { |transaction| transaction.created_at == created_at }
  end

  def find_by_date_updated(updated_at)
    transactions.detect { |transaction| transaction.updated_at == updated_at }
  end

  def find_all_by_credit_card_number(credit_card)
    transactions.select { |transaction| transaction.credit_card_number == credit_card }
  end

  def find_all_by_result(result)
    transactions.select { |transaction| transaction.result == result }
  end

  def find_all_by_expiration_date(expiration_date)
    transactions.select do |transaction|
      if transaction.credit_card_expiration_date.nil?
        return "No Exp Date"
      else
        transaction.credit_card_expiration_date == expiration_date
      end
    end
  end

  def find_all_by_date_created(created_at)
    transactions.select { |transaction| transaction.created_at == created_at }
  end

  def find_all_by_date_updated(updated_at)
    transactions.select { |transaction| transaction.updated_at == updated_at }
  end

end
