require_relative 'sales_engine'

class CustomerRepository

  attr_reader :engine

  def initialize #without initializing sales engine?
    @engine = SalesEngine.new
  end

end

#find by
#all
#find all

#access to full table from salesengine
#have to assign the headers to attributes
#write methods
  #all
  #random
  #find_all_by(x)
