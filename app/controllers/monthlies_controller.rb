class MonthliesController < ApplicationController
  # GET /monthlies
  # GET /monthlies.xml
  def index
    @monthlies = Monthly.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @monthlies }
    end
  end

  # GET /monthlies/1
  # GET /monthlies/1.xml
  def show
    @monthly = Monthly.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @monthly }
    end
  end

  # GET /monthlies/new
  # GET /monthlies/new.xml
  def new
    @monthly = Monthly.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @monthly }
    end
  end

  # GET /monthlies/1/edit
  def edit
    @monthly = Monthly.find(params[:id])
  end

  # POST /monthlies
  # POST /monthlies.xml
  def create
    @monthly = Monthly.new(params[:monthly])

    respond_to do |format|
      if @monthly.save
        format.html { redirect_to(@monthly, :notice => 'Monthly was successfully created.') }
        format.xml  { render :xml => @monthly, :status => :created, :location => @monthly }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @monthly.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /monthlies/1
  # PUT /monthlies/1.xml
  def update
    @monthly = Monthly.find(params[:id])

    respond_to do |format|
      if @monthly.update_attributes(params[:monthly])
        format.html { redirect_to(@monthly, :notice => 'Monthly was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @monthly.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /monthlies/1
  # DELETE /monthlies/1.xml
  def destroy
    @monthly = Monthly.find(params[:id])
    @monthly.destroy

    respond_to do |format|
      format.html { redirect_to(monthlies_url) }
      format.xml  { head :ok }
    end
  end
end
