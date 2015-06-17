require_relative 'sales_engine'
require_relative 'merchant'

class MerchantRepository

  attr_reader :rows, :merchants

  def initialize(rows, sales_engine)
    @rows = rows.read
    @sales_engine = sales_engine
    @merchants = merchant_parser
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
