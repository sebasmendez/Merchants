class StoreController < ApplicationController
  
  proc {|c| c.request.xhr? ? false : 'application'}
  
  def index
    @products = Product.order('name DESC').paginate(page: params[:page], per_page: 5)
    @products = Product.search(params[:search]).order('name DESC').paginate(page: params[:page], per_page: 5) if params[:search]
    @cart ||= current_cart
    @cart.add_product(@products.first.id).save if @products.size == 1
    
      respond_to do |format|
        format.js {render js: @products}
        format.html
      end
  end
  
end
