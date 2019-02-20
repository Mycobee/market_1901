class Market
  attr_reader :name,
              :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map {|vendor| vendor.name}
  end

  def vendors_that_sell(item)
    vendor_sellers = @vendors.select {|vendor| vendor.inventory.keys.include?(item)}

  end

  def sorted_item_list
    inventories = vendors.map {|vendor| vendor.inventory}
    inventory_names = inventories.map {|item_hash| item_hash.keys}.flatten
    sorted_item_list = inventory_names.uniq.sort
  end

  def total_inventory
    total_inventory = {}
    @vendors.each do |vendor|
      vendor.inventory.keys.each do |key|
        if !total_inventory.keys.include?(key)
          total_inventory[key] = 0
        end
      end
      total_inventory
    end

    @vendors.each do |vendor|
      vendor.inventory.each do |inventory_key, inventory_value|
        total_inventory[inventory_key] += inventory_value
      end
      total_inventory
    end

    total_inventory
  end

  def sell(item_name, sale_quantity)
    if total_inventory[item_name].to_i >= sale_quantity
      true
    else
      false
    end
  end


end
