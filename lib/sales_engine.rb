require_relative 'csv_parser'
require_relative 'merchant_repository'
require_relative 'customer_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'item_repository'
require_relative 'transaction_repository'

class SalesEngine

  include CSVParser
  attr_accessor :customer_repository,
                :merchant_repository,
                :invoice_repository,
                :invoice_items_repository,
                :item_repository,
                :transaction_repository

  attr_reader :customer_rows,
              :merchant_rows,
              :invoice_rows,
              :invoice_items_rows,
              :item_rows,
              :transaction_rows

  def initialize
    @customer_rows = CSVParser.customer_rows
    @merchant_rows = CSVParser.merchant_rows
    @invoice_rows = CSVParser.invoice_rows
    @invoice_items_rows = CSVParser.invoice_items_rows
    @item_rows = CSVParser.item_rows
    @transaction_rows = CSVParser.transaction_rows
    startup
  end

  def startup
    @customer_repository = CustomerRepository.new(customer_rows, self)
    @merchant_repository = MerchantRepository.new(merchant_rows, self)
    @invoice_repository = InvoiceRepository.new(invoice_rows, self)
    @invoice_items_repository = InvoiceItemRepository.new(invoice_items_rows, self)
    @item_repository = ItemRepository.new(item_rows, self)
    @transaction_repository = TransactionRepository.new(transaction_rows, self)
  end

  def find_all_by_merchant_id(merchant_id)
    item_repository.find_items_by_merchant_id(merchant_id)
  end
end

