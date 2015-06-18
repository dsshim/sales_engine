require "minitest/autorun"
require "minitest/pride"
require "./lib/item_repository"
class ItemRepositoryTest < Minitest::Test

  attr_reader :item_repository, :sales_engine

  def setup
    rows = CSV.open "./data/fixtures/item_test.csv", headers: true, header_converters: :symbol
    read_rows = rows.read
    @item_repository = ItemRepository.new(read_rows, sales_engine)
  end

  def test_it_loads_on_initialize
    assert item_repository
    assert item_repository.items
  end

  def test_it_creates_items_by_taking_data_from_the_repo
    assert_equal 40, item_repository.items.count
  end

  def test_it_has_access_to_the_data
    assert_equal "Item Qui Esse", item_repository.items.first.name
  end

  def test_it_has_access_to_other_types_of_data
    assert_equal 1, item_repository.items.first.merchant_id
  end

  def test_it_finds_all_items
    assert_equal item_repository.items, item_repository.all
  end

  def test_it_returns_a_random_item
    first_item = item_repository.random
    second_item = item_repository.random

    refute_equal first_item, second_item
  end

  def test_it_finds_items_by_id
    assert_equal 1, item_repository.find_by_id(1).id
  end

  def test_it_finds_items_by_name
    assert_equal "Item Qui Esse", item_repository.find_by_name("Item Qui Esse").name
  end

  def test_it_finds_items_by_description
    description = "Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro."
    assert_equal description, item_repository.find_by_description(description).description
  end

  def test_it_finds_items_by_unit_price
    assert_equal 75107, item_repository.find_by_unit_price(75107).unit_price
  end

  def test_it_finds_items_by_merchant_id
    assert_equal 1, item_repository.find_by_merchant_id(1).merchant_id
  end

  def test_it_finds_items_by_date_created
    date = "2012-03-27 14:53:59 UTC"
    assert_equal date, item_repository.find_by_date_created("2012-03-27 14:53:59 UTC").created_at
  end

  def test_it_finds_items_by_date_updated
    date = "2012-03-27 14:53:59 UTC"
    assert_equal date, item_repository.find_by_date_updated("2012-03-27 14:53:59 UTC").updated_at
  end

  def test_it_finds_all_items_by_name # do we need to have this method?
    assert_equal 1, item_repository.find_all_by_name("Item Dolor Odio").count
  end

  def test_it_finds_all_items_by_description # do we need this?
    description = "Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro."
    assert_equal 1, item_repository.find_all_by_description(description).count
  end

  def test_it_finds_all_items_by_unit_price # do we need this?
    assert_equal 1, item_repository.find_all_by_unit_price(31163).count
  end

  def test_it_finds_all_items_by_merchant_id
    assert_equal 15, item_repository.find_all_by_merchant_id(1).count
  end

  def test_it_finds_all_items_by_date_created
    assert_equal 40, item_repository.find_all_by_date_created("2012-03-27 14:53:59 UTC").count
  end

  def test_it_finds_all_items_by_date_created
    assert_equal 40, item_repository.find_all_by_date_updated("2012-03-27 14:53:59 UTC").count
  end
end
