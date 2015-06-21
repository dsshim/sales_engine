require_relative 'sales_engine'
require_relative 'merchant'

class MerchantRepository

  attr_reader :rows, :merchants, :sales_engine

  def initialize(rows, sales_engine)
    @rows = rows
    @sales_engine = sales_engine
    @merchants = merchant_parser
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def merchant_parser
    rows.map { |row| Merchant.new(row, self) }
  end

  def all
    merchants
  end

  def random
    merchants.sample
  end

  def find_items_by_merchant_id(merchant_id)
    sales_engine.find_items_by_merchant_id(merchant_id)
  end

  def find_transactions_by_invoice_id(invoice_id)
  sales_engine.find_transactions_by_invoice_id(invoice_id)
  end

  def find_invoices_by_merchant_id(merchant_id)
    sales_engine.find_invoices_by_merchant_id(merchant_id)
  end

  def find_by_id(id)
    merchants.detect { |merchant| merchant.id == id }
  end

  def find_by_name(name)
    merchants.detect { |merchant| merchant.name == name }
  end

  def find_by_date_created(created_at)
    merchants.detect { |merchant| merchant.created_at == created_at }
  end

  def find_by_date_updated(updated_at)
    merchants.detect { |merchant| merchant.updated_at == updated_at }
  end

  def find_all_by_id(id)
    merchants.select { |merchant| merchant.id == id }
  end

  def find_all_by_name(name)
    merchants.select { |merchant| merchant.name == name }
  end

  def find_all_by_date_created(created_at)
    merchants.select { |merchant| merchant.created_at == created_at }
  end

  def find_all_by_date_updated(updated_at)
    merchants.select { |merchant| merchant.updated_at == updated_at }
  end
end
