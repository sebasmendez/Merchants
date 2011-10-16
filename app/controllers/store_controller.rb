class StoreController < ApplicationController
  
  #proc { |controller| controller.request.xhr? ? false : 'application'}
  
  def index
    @products = Product.order(:name)
    @cart = current_cart
  end
  

end
