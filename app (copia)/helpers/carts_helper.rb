module CartsHelper
  def change_quantity(item)
    #@cart = item
    quanty = prompt "Quantity "
    
  end
  
  def prompt(*args)
    print(*args)
    gets
  end

end
