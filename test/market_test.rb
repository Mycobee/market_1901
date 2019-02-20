require 'minitest/autorun'
require 'minitest/pride'
require './lib/market'
require './lib/vendor'
require 'pry'

class MarketTest < Minitest::Test
  def setup
    @market = Market.new("South Pearl Street Farmers Market")
    @vendor_1 = Vendor.new("Rocky Mountain Fresh")
    @vendor_1.stock("Peaches", 35)
    @vendor_1.stock("Tomatoes", 7)
    @vendor_2 = Vendor.new("Ba-Nom-a-Nom")
    @vendor_2.stock("Banana Nice Cream", 50)
    @vendor_2.stock("Peach-Raspberry Nice Cream", 25)
    @vendor_3 = Vendor.new("Palisade Peach Shack")
    @vendor_3.stock("Peaches", 65)
  end

  def test_it_exists
    assert_instance_of Market, @market
  end

  def test_it_has_a_name
    assert_equal "South Pearl Street Farmers Market", @market.name
  end

  def test_it_start_with_an_empty_array_of_vendors
    assert_equal [], @market.vendors
  end

  def test_add_vendor_method
    @market.add_vendor(@vendor_1)
    @market.add_vendor(@vendor_2)
    @market.add_vendor(@vendor_3)
    expected = [@vendor_1, @vendor_2, @vendor_3]
    actual = @market.vendors
  end

  def test_vendor_names
    @market.add_vendor(@vendor_1)
    @market.add_vendor(@vendor_2)
    @market.add_vendor(@vendor_3)

    expected = ["Rocky Mountain Fresh", "Ba-Nom-a-Nom", "Palisade Peach Shack"]
    actual = @market.vendor_names
  end

  def test_vendors_that_sell_method
    @market.add_vendor(@vendor_1)
    @market.add_vendor(@vendor_2)
    @market.add_vendor(@vendor_3)
    expected_1 = [@vendor_1, @vendor_3]
    actual_1 = @market.vendors_that_sell("Peaches")
    assert_equal expected_1, actual_1

    expected_2 = [@vendor_2]
    actual_2 = @market.vendors_that_sell("Banana Nice Cream")
    assert_equal expected_2, actual_2
  end

  def test_sorted_item_list
    @market.add_vendor(@vendor_1)
    @market.add_vendor(@vendor_2)
    @market.add_vendor(@vendor_3)
    expected = ["Banana Nice Cream", "Peach-Raspberry Nice Cream", "Peaches", "Tomatoes"]
    actual = @market.sorted_item_list
    assert_equal expected, actual
  end

  def test_total_inventory
    @market.add_vendor(@vendor_1)
    @market.add_vendor(@vendor_2)
    @market.add_vendor(@vendor_3)
    expected = {"Peaches"=>100, "Tomatoes"=>7, "Banana Nice Cream"=>50, "Peach-Raspberry Nice Cream"=>25}
    actual = @market.total_inventory
    assert_equal expected, actual
  end

  def test_sell_method
    @market.add_vendor(@vendor_1)
    @market.add_vendor(@vendor_2)
    @market.add_vendor(@vendor_3)
    actual_1 = @market.sell("Peaches", 200)
    expected_1 = false
    assert_equal expected_1, actual_1

    actual_2 = @market.sell("Onions", 1)
    expected_2 = false
    assert_equal expected_2, actual_2

    actual_3 = @market.sell("Banana Nice Cream", 5)
    expected_3 = true
    assert_equal expected_3, actual_3

    assert_equal 45, @vendor_2.check_stock("Banana Nice Cream")

    assert_equal true, @market.sell("Peaches", 40)

    assert_equal 0, @vendor_1.check_stock("Peaches")
  end


end
