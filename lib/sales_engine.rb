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
              :transaction_rows,
              :filepath

  def initialize(filepath = nil)
    @filepath = filepath
  end

  def startup
    @customer_repository
    @merchant_repository
    @invoice_repository
    @invoice_item_repository
    @item_repository
    @transaction_repository
  end

  def customer_repository
    @customer_repository ||= CustomerRepository.new(CSVParser.customer_rows, self)
  end

  def merchant_repository
    @merchant_repository ||= MerchantRepository.new(CSVParser.merchant_rows, self)
  end

  def invoice_repository
    @invoice_repository ||= InvoiceRepository.new(CSVParser.invoice_rows, self)
  end

  def invoice_item_repository
    @invoice_item_repository ||= InvoiceItemRepository.new(CSVParser.invoice_items_rows, self)
  end

  def item_repository
    @item_repository ||= ItemRepository.new(CSVParser.item_rows, self)
  end

  def transaction_repository
    @transaction_repository ||= TransactionRepository.new(CSVParser.transaction_rows, self)
  end

  def find_merchants_by_id(id) # item_repo line 40
    merchant_repository.find_all_by_id(id)
  end

  def find_invoices_by_customer_id(id)
    customer_repository.find_all_by_customer_id(id)
  end

  def find_customer_by_id(customer_id)
    customer_repository.find_by_id(customer_id)
  end

  def find_invoices_by_merchant_id(merchant_id)
    invoice_repository.find_all_by_merchant_id(merchant_id)
  end

  def find_invoice_by_id(invoice_id)
    invoice_repository.find_by_id(invoice_id)
  end

  def find_invoices_by_id(id)
    invoice_repository.find_all_by_id(id)
  end

  def find_invoices_by_inv_id(invoice_id)
    invoice_repository.find_multiple_by_id(invoice_id)
  end

  def find_invoices_by_customer_id_from_customer(customer_id)
    invoice_repository.find_all_by_customer_id(customer_id)
  end

  def find_invoices_by_date_created(created_at)
    invoice_repository.find_all_by_date_created_string_input(created_at)
  end

  def find_all_invoice_items
    invoice_item_repository.all
  end

  def find_invoice_items_by_id(invoice_id)
    invoice_item_repository.find_all_by_invoice_id(invoice_id)
  end

  def find_invoice_items_by_invoice_ids(invoice_ids)
    invoice_item_repository.find_multiple_by_invoice_id(invoice_ids)
  end

  def find_items_by_id(item_id)
    invoice_item_repository.find_all_by_item_id(item_id)
  end

  def create_invoice_items(id, invoice_id, quantity, unit_price)
    invoice_item_repository.create_invoice_items(id, invoice_id, quantity, unit_price)
  end

  def find_items_by_item_id(item_id)
    item_repository.find_all_by_id(item_id)
  end

  def find_all_by_item_id(item_ids)
    item_repository.find_multiple_by_id(item_ids)
  end

  def find_item_by_item_id(item_id)
    item_repository.find_by_id(item_id)
  end

  def find_items_by_merchant_id(merchant_id)
    item_repository.find_all_by_merchant_id(merchant_id)
  end

  def find_invoices_by_invoice_id(invoice_id)
    transaction_repository.find_all_by_invoice_id(invoice_id)
  end

  def find_transactions_by_result(result)
    transaction_repository.find_all_by_result(result)
  end

  def find_transactions_by_invoice_ids(ids)
    transaction_repository.find_multiple_transactions_by_invoice_id(ids)
  end

  def find_transactions_by_inv_id_for_merchant(invoice_id)
    transaction_repository.find_all_by_invoice_id(invoice_id)
  end

  def create_transaction(data, id)
    transaction_repository.create_transaction(data, id)
  end
end
