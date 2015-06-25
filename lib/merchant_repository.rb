require_relative 'sales_engine'
require_relative 'merchant'

class MerchantRepository

  attr_reader   :rows,
                :merchants,
                :engine
  attr_accessor :most_items,
                :revenue,
                :most_revenue

  def initialize(rows, engine)
    @rows = rows
    @engine = engine
    @merchants = merchant_parser
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def merchant_parser
    rows.map { |row| Merchant.new(row, self) }
  end

  def all
    Hash[merchants.map { |m| [m.id, m] }]
  end

  def random
    merchants.sample
  end

  def most_items(quantity)
    @most_items ||= calculate_most_items_by_merchant(quantity)
  end

  def revenue(date)
    @revenue ||= all.map { |id, m| m.revenue(date)}.reduce(:+)
  end

  def most_revenue(quantity)
    most = all.max_by(quantity) do |id, m|
      m.revenue
    end.flatten.drop(1)
  end

  def find_items_by_merchant_id(merchant_id)
    engine.find_items_by_merchant_id(merchant_id)
  end

  def find_transactions_by_invoice_id(invoice_ids)
    engine.find_transactions_by_invoice_id(invoice_ids)
  end

  def find_transactions_by_inv_id_for_merchant(invoice_id)
    engine.find_transactions_by_inv_id_for_merchant(invoice_id)
  end

  def find_multiple_transactions_by_invoice_id(ids)
    engine.find_multiple_transactions_by_invoice_id(ids)
  end

  def find_invoice_items_by_invoice_id(invoice_ids)
    engine.find_invoice_items_by_id(invoice_ids)
  end

  def find_all_invoice_items
    engine.find_all_invoice_items
  end

  def find_invoices_by_merchant_id(merchant_id)
    engine.find_invoices_by_merchant_id(merchant_id)
  end

  def find_items_by_item_id(item_id)
    engine.find_items_by_item_id(item_id)
  end

  def find_invoices_by_ids(invoice_ids)
    engine.find_invoices_by_inv_id(invoice_ids)
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

  private

  def calculate_most_items_by_merchant(quantity)
    merchant_quantity = merchants.map do |merchant|
      merchant.items.map do |item|
        item.quantity_sold
      end.reduce(:+)
    end
    merchant_ids = merchants.map(&:id)
    pairs = merchant_ids.zip(merchant_quantity)
    top_pairs = pairs.sort_by(&:last).reverse.take(quantity)
    top_pairs.map { |element| find_by_id(element[0]) }
  end
end
