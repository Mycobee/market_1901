require 'minitest/autorun'
require 'minitest/pride'
require './lib/vendor'
require 'pry'

class VendorTest < Minitest::Test
  def test_it_exists
    vendor = Vendor.new("Rocky Mountain Fresh")
    assert_instance_of Vendor, vendor
  end

  def test_it_has_a_name
    vendor = Vendor.new("Rocky Mountain Fresh")
    assert_equal "Rocky Mountain Fresh", vendor.name
  end

  def test_inventory_starts_as_empty_hash
    vendor = Vendor.new("Rocky Mountain Fresh")
    assert_equal ({}), vendor.inventory
  end

  def test_check_stock
    vendor = Vendor.new("Rocky Mountain Fresh")
    expected = 0
    actual = vendor.check_stock("Peaches")
    assert_equal expected, actual
  end

  def test_stock_method_corresponds_with_check_stock_and_inventory
    vendor = Vendor.new("Rocky Mountain Fresh")
    actual_1 = vendor.stock("Peaches", 30)
    expected_1 = 30
    vendor.check_stock("Peaches")

    assert_equal expected_1, actual_1
     # binding.pry
    vendor.stock("Peaches", 25)
    expected_2 = 55
    actual_2 = vendor.check_stock("Peaches")
    assert_equal expected_2, actual_2

    vendor.stock("Tomatoes", 12)
    expected_3 = {"Peaches"=>55, "Tomatoes"=>12}
    actual_3 = vendor.inventory
    assert_equal expected_3, actual_3
  end

end
