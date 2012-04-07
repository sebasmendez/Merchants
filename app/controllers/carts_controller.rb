class CartsController < ApplicationController
  
  # GET /carts
  # GET /carts.json
  def index
    @cart = Cart.order('name ASC')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cart }
    end
  end

  # GET /carts/1
  # GET /carts/1.json
  def show
    begin
    @cart = Cart.find(params[:id])
    rescue ActiveRecord::RecordNotFound
    logger.error "Attemp access to invalid cart #{params[:id]}"
    redirect_to store_url, notice: t('cart.invalid')
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cart }
    end
  end

  # GET /carts/new
  # GET /carts/new.json
  def new
    @cart = Cart.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cart }
    end
  end

  # POST /carts
  # POST /carts.json
  def create
    @cart = Cart.new(params[:cart])

    respond_to do |format|
      if @cart.save
        format.html { redirect_to @cart, notice: t('cart.create') }
        format.json { render json: @cart, status: :created, location: @cart }
      else
        format.html { render action: "new" }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /carts/1
  # PUT /carts/1.json
  def update
    @cart = Cart.find(params[:id])

    respond_to do |format|
      if @cart.update_attributes(params[:cart])
        format.html { redirect_to @cart, notice: 'Cart was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carts/1
  # DELETE /carts/1.json
  def destroy
    @cart ||= current_cart
    @cart.destroy
    session[:cart_id] = nil

    respond_to do |format|
      format.html { redirect_to store_url, notice: t('cart.emptied') }
      format.json { head :ok }
    end
  end
end
