module OrdersHelper
  
  def products_to_buy
    @cart = current_cart
    @cart.line_items.each do |item|
      a = 1
      list[a] = item
      a +=1
     return list
    end
  end
  def debt
    [false, true]
  end
end
