class StoreController < ApplicationController
  
  proc {|c| c.request.xhr? ? false : 'application'}
  
  def index
    @products = Product.order(:name)
    @cart = current_cart
  end
  
  
end
