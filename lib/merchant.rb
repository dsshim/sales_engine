require_relative 'merchant_repository'
require 'bigdecimal'

class Merchant

  attr_reader :id,
              :name,
              :created_at,
              :updated_at,
              :repository


  def initialize(row, repo)
    @repository = repo
    @id = row[:id].to_i
    @name = row[:name]
    @created_at = row[:created_at]
    @updated_at = row[:updated_at]
  end

  def items
    repository.find_items_by_merchant_id(id)
  end

  def invoices
    repository.find_invoices_by_merchant_id(id)
  end

  def revenue
    calculate_revenue
  end

  def get_invoice_id_from_filtered_transactions
    invoice_ids = filter_transactions.map { |transaction| transaction.map(&:invoice_id) }.flatten
    invoice_ids.map { |invoice_id| repository.find_invoice_items_by_invoice_id(invoice_id) }
  end

  def filter_transactions
    invoices.map do |invoice|
      invoice.transactions.select do |transaction|
        transaction.result == 'success'
      end
    end
  end

  def calculate_revenue
    invoice_items = get_invoice_id_from_filtered_transactions
    invoice_items_price = invoice_items.flatten.map do |invoice_item|
      invoice_item.unit_price
    end
    invoice_items_quantity = invoice_items.flatten.map do |invoice_item|
      invoice_item.quantity
    end

    pairs = invoice_items_price.zip(invoice_items_quantity)
    sum = pairs.map { |element| element.reduce(:*) }.reduce(:+)
    bd_sum = sum.to_f / 100
    BigDecimal.new("#{bd_sum}")
  end
end

