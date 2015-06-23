require_relative 'merchant_repository'
require 'bigdecimal'

class Merchant

  attr_reader :id,
              :name,
              :created_at,
              :updated_at,
              :repository
  attr_accessor :items,
                :invoices


  def initialize(row, repo)
    @repository = repo
    @id = row[:id].to_i
    @name = row[:name]
    @created_at = row[:created_at]
    @updated_at = row[:updated_at]
  end

  def items
    @items ||= repository.find_items_by_merchant_id(id)
  end

  def invoices
    @invoices ||= repository.find_invoices_by_merchant_id(id)
  end

  def revenue(date = nil)
    filtered = filter_transactions(date)
    invoice_ids = get_invoice_id_from_filtered_transactions(filtered)
    invoice_items = get_invoice_items_from_invoice_ids(invoice_ids)
    calculate_revenue(invoice_items)
  end

  def favorite_customer
    transactions = filter_transactions
    invoice_ids = get_invoice_id_from_filtered_transactions(transactions)
    invoices = repository.find_invoices_by_ids(invoice_ids)
    groups = invoices.group_by {|invoice| invoice.customer_id }
    sorted = groups.sort_by { |group| -group[1].count }
    sorted.first[1].first.customer
  end

  def filter_transactions(date = nil)
    date ? invoices = filter_invoices(date) : invoices = repository.find_invoices_by_merchant_id(id)
    invoices.map do |invoice|
      invoice.transactions.select do |transaction|
        transaction.result == 'success'
      end
    end
  end

  def filter_invoices(date)
    invoices.select {|invoice| Date.parse(invoice.created_at) == date }
  end

  def get_invoice_id_from_filtered_transactions(filtered)
    filtered.map { |transaction| transaction.map(&:invoice_id) }.flatten
  end

  def get_invoice_items_from_invoice_ids(invoice_ids)
    invoice_ids.map { |invoice_id| repository.find_invoice_items_by_invoice_id(invoice_id) }
  end

  def calculate_revenue(invoice_items)
    invoice_items_price = invoice_items.flatten.map {|invoice_item|
                                                      invoice_item.unit_price }
    invoice_items_quantity = invoice_items.flatten.map {|invoice_item|
                                                      invoice_item.quantity }
    pairs = invoice_items_price.zip(invoice_items_quantity)
    sum = pairs.map { |element| element.reduce(:*) }.reduce(:+)
    bd_sum = sum.to_f / 100
    BigDecimal.new("#{bd_sum}")
  end
end

