require_relative 'merchant_repository'

class Merchant

  attr_reader :id,
              :name,
              :created_at,
              :updated_at

  def initialize(row, repo)
    @repository = repo
    @id = row[:id]
    @name = row[:name]
    @created_at = row[:created_at]
    @updated_at = row[:updated_at]
  end
end
