require 'csv'

module CSVParser

  def self.customer_rows
    CSV.read "./data/customers.csv", headers: true, header_converters: :symbol
  end

  def self.merchant_rows
    CSV.read "./data/merchants.csv", headers: true, header_converters: :symbol
  end

  def self.invoice_rows
    CSV.read "./data/invoices.csv", headers: true, header_converters: :symbol
  end

  def self.invoice_items_rows
    CSV.read "./data/invoice_items.csv", headers: true, header_converters: :symbol
  end

  def self.item_rows
    CSV.read "./data/items.csv", headers: true, header_converters: :symbol
  end

  def self.transaction_rows
    CSV.read "./data/transactions.csv", headers: true, header_converters: :symbol
  end
end
