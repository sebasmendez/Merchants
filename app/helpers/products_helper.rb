module ProductsHelper
 
  def prod_uni
    ['Kg', 'g', 'L', 'ml', 'Unidades']
  end
  
  def product_exist_in_line_item(product_id)
    @cart = current_cart
    
    @cart.line_items.each do |item|
      if product_id.to_i == item.product.id.to_i 
        return true
      end
    end
  end
  
  def iva_percent
    [21, 10.5, 0]
  end
  
  def earn_percent
    
  end
  
end
