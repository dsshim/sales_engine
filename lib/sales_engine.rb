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
    startup
  end

  def startup
    parse_data
    @customer_repository = CustomerRepository.new(customer_rows, self)
    @merchant_repository = MerchantRepository.new(merchant_rows, self)
    @invoice_repository = InvoiceRepository.new(invoice_rows, self)
    @invoice_items_repository = InvoiceItemRepository.new(invoice_items_rows, self)
    @item_repository = ItemRepository.new(item_rows, self)
    @transaction_repository = TransactionRepository.new(transaction_rows, self)
  end

  def parse_data
    @customer_rows = CSVParser.customer_rows
    @merchant_rows = CSVParser.merchant_rows
    @invoice_rows = CSVParser.invoice_rows
    @invoice_items_rows = CSVParser.invoice_items_rows
    @item_rows = CSVParser.item_rows
    @transaction_rows = CSVParser.transaction_rows
  end

  def find_items_by_merchant_id(merchant_id)
    item_repository.find_all_by_merchant_id(merchant_id)
  end

  def find_invoices_by_merchant_id(merchant_id)
    invoice_repository.find_all_by_merchant_id(merchant_id)
  end

  def find_invoices_by_invoice_id(invoice_id)
    transaction_repository.find_all_by_invoice_id(invoice_id)
  end

  def find_invoice_items_by_id(invoice_id)
    invoice_items_repository.find_all_by_invoice_id(invoice_id)
  end

  def find_items_by_invoice_id_thru_invoice_items(invoice_id)
    invoice_items = invoice_items_repository.find_all_by_invoice_id(invoice_id)
    item_repository.find_all_by_item_id(invoice_items[:item_id]) #is this correct?
  end

  def find_invoices_by_customer_id(id)
    customer_repository.find_all_by_customer_id(id)
  end

  def find_merchant_invoices_by_id(id)
    merchant_repository.find_all_by_id(id)
  end

  def find_invoice_items_by_invoice_id(id)
    invoice_repository.find_all_by_id(id)
  end

  def find_invoice_items_by_item_id(id)
    item_repository.find_all_by_id(id)
  end

  def find_items_by_id(item_id)
    invoice_items_repository.find_all_by_item_id(item_id)
  end

  def find_merchants_by_id(id)
    merchant_repository.find_all_by_id(id)
  end

  def find_invoices_by_id(id)
    invoice_repository.find_all_by_id(id)
  end

  def find_invoices_by_customer_id_from_customer(customer_id)
    invoice_repository.find_all_by_customer_id(customer_id)
  end
end

