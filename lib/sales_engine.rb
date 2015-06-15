require 'csv'
require_relative 'merchant'
require_relative 'merchant_repository'
require_relative 'customer'
require_relative 'customer_repository'
require_relative 'invoice'
require_relative 'invoice_repository'
require_relative 'invoice_item'
require_relative 'invoice_item_repository'
require_relative 'item'
require_relative 'item_repository'
require_relative 'transaction'
require_relative 'transaction_repository'

class SalesEngine

  attr_reader :customers_repository,
              :merchant_repository,
              :invoice_repository,
              :invoice_items_repository,
              :item_repository,
              :transaction_repository

  def startup
    customer_repository
    merchant_repository
    invoice_repository
    invoice_items_repository
    item_repository
    transaction_repository
  end

  def customer_repository
   @customer_repository ||= CSV.open "./data/customers.csv", headers: true, header_converters: :symbol
  end

  def merchant_repository
    @merchant_repository ||= CSV.open "./data/merchants.csv", headers: true, header_converters: :symbol
  end

  def invoice_repository
    @invoice_repository ||= CSV.open "./data/invoices.csv", headers: true, header_converters: :symbol
  end

  def invoice_item_repository
    @invoice_item_repository ||= CSV.open "./data/invoice_items.csv", headers: true, header_converters: :symbol
  end

  def item_repository
    @item_repository ||= CSV.open "./data/items.csv", headers: true, header_converters: :symbol
  end

  def transaction_repository
    @transaction_repository ||= CSV.open "./data/transactions.csv", headers: true, header_converters: :symbol
  end
end

