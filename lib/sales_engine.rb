require 'csv'
require_relative 'merchant_repository'
require_relative 'customer_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'item_repository'
require_relative 'transaction_repository'

class SalesEngine

  attr_accessor :customer_repository,
              :merchant_repository,
              :invoice_repository,
              :invoice_items_repository,
              :item_repository,
              :transaction_repository


  def initialize
    @customer_repository = CustomerRepository.new(customer_rows, self)
    @merchant_repository = MerchantRepository.new(merchant_rows, self)
    @invoice_repository = InvoiceRepository.new(invoice_rows, self)
    @invoice_items_repository = InvoiceItemRepository.new(invoice_item_rows, self)
    @item_repository = ItemRepository.new(item_rows, self)
    @transaction_repository = TransactionRepository.new(transaction_rows, self)
  end

  def customer_rows #here we need to instantiate customer_repo class
   customer_rows ||= CSV.open "../data/customers.csv", headers: true, header_converters: :symbol
  end

  def merchant_rows
    merchant_rows ||= CSV.open "../data/merchants.csv", headers: true, header_converters: :symbol
  end

  def invoice_rows
    invoice_rows ||= CSV.open "../data/invoices.csv", headers: true, header_converters: :symbol
  end

  def invoice_item_rows
    invoice_item_rows ||= CSV.open "../data/invoice_items.csv", headers: true, header_converters: :symbol
  end

  def item_rows
    item_rows ||= CSV.open "../data/items.csv", headers: true, header_converters: :symbol
  end

  def transaction_rows
    transaction_rows ||= CSV.open "../data/transactions.csv", headers: true, header_converters: :symbol
  end
end

