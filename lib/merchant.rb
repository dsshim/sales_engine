require_relative 'merchant_repository'
require 'bigdecimal'

class Merchant

  attr_reader :id,
              :name,
              :created_at,
              :updated_at,
              :repository

  attr_accessor :items,
                :invoices,
                :invoice_items,
                :successful_invoices

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

  def invoice_items
    @invoice_items ||= repository.find_all_invoice_items
  end

  def successful_invoices
    @successful_invoices ||= successful_invoices
  end

  def revenue(date = nil)
    calculate_revenue(date)
  end

  def favorite_customer
    find_favorite_customer
  end

  def customers_with_pending_invoices
    pending_invoices
  end

  private

  def calculate_revenue(date = nil )
    filtered = filter_transactions(date)
    filtered_invoice_items = filtered
      .flatten.map(&:invoice).map(&:invoice_items)
    calculate_revenue_from_invoice_items(filtered_invoice_items)
  end

  def calculate_revenue_from_invoice_items(ii)
    sum = ii.map do |element|
      element.map { |ii| ii.quantity * ii.unit_price }.reduce(:+)
    end.reduce(:+)
     bd_sum = sum.to_f / 100
    BigDecimal.new("#{bd_sum}")
  end

  def find_favorite_customer
    transactions = filter_transactions
    invoices = transactions.flatten.map(&:invoice)
    invoices.group_by(&:customer_id).sort_by {|value| -value.last.count }
      .flatten[1].customer
  end

  def pending_invoices
    pending = invoices.select do |i|
      successful = i.transactions.any? { |t| t.successful? }
      i if !successful
    end
    pending.map(&:customer)
  end

  def filter_transactions(date = nil)
    inv = date ? filter_by_date(date) : invoices
    successful_invoices(inv)
  end

  def successful_invoices(inv)
    inv = inv.map do |i|
      i.transactions.select do |t|
        t.successful?
      end
    end
  end

  def filter_by_date(date)
    invoices.select { |invoice| Date.parse(invoice.created_at) == date }
  end
end
