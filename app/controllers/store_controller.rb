class StoreController < ApplicationController
  
  proc {|c| c.request.xhr? ? false : 'application'}
  
  def index
    @products = Product.search(params[:search]).order('name DESC') if params[:search]
    @products = Product.order('name DESC').paginate(page: params[:page], per_page: 5)
    @cart = current_cart
  end
  
  
end
