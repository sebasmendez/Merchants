class StoreController < ApplicationController
  
  proc {|c| c.request.xhr? ? false : 'application'}
  
  def index
    @products = Product.search(params[:search]).order('name DESC')
    @cart = current_cart
  end
  
  
end
