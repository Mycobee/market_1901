class Vendor
  attr_reader :name,
              :inventory


  def initialize(name)
    @name = name
    @inventory = {}
  end

  def check_stock(item)
      if @inventory[item] == nil
        @inventory[item] = 0
      end
      @inventory[item]
  end

  def stock(name, count)
     @inventory[name] = count + @inventory[name].to_i
  end
end
