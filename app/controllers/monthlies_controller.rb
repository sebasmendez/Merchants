# enconding: UTF-8

class MonthliesController < ApplicationController
  
  # GET /monthlies
  # GET /monthlies.xml
  def index
    @monthlies = Box.by_months

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @monthlies }
    end
  end
end
