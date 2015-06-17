require 'csv'

module CSVParser

  def self.customer_rows #here we need to instantiate customer_repo class
   customer_rows ||= CSV.open "./data/customers.csv", headers: true, header_converters: :symbol
  end

  def self.merchant_rows
    merchant_rows ||= CSV.open "./data/merchants.csv", headers: true, header_converters: :symbol
  end

  def self.invoice_rows
    invoice_rows ||= CSV.open "./data/invoices.csv", headers: true, header_converters: :symbol
  end

  def self.invoice_items_rows
    invoice_items_rows ||= CSV.open "./data/invoice_items.csv", headers: true, header_converters: :symbol
  end

  def self.item_rows
    item_rows ||= CSV.open "./data/items.csv", headers: true, header_converters: :symbol
  end

  def self.transaction_rows
    transaction_rows ||= CSV.open "./data/transactions.csv", headers: true, header_converters: :symbol
  end
end
