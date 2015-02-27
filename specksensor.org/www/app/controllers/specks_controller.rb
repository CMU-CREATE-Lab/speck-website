class SpecksController < ApplicationController
  layout nil

  # GET /specks
  # GET /specks.json
  def index
    @specks = Speck.all

    respond_to do |format|
      format.html { render :layout => false } # index.html.erb
      format.json { render json: @specks }
      
    end
  end

  # GET /specks/1
  # GET /specks/1.json
  def show
    @speck = Speck.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @speck }
    end
  end

  # GET /specks/new
  # GET /specks/new.json
  def new
    @speck = Speck.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @speck }
    end
  end

  # GET /specks/1/edit
  def edit
    @speck = Speck.find(params[:id])
  end

  # POST /specks
  # POST /specks.json
  def create
    @speck = Speck.new(params[:speck])

    respond_to do |format|
      if @speck.save
        format.html { redirect_to @speck, notice: 'Speck was successfully created.' }
        format.json { render json: @speck, status: :created, location: @speck }
      else
        format.html { render action: "new" }
        format.json { render json: @speck.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /specks/1
  # PUT /specks/1.json
  def update
    @speck = Speck.find(params[:id])

    respond_to do |format|
      if @speck.update_attributes(params[:speck])
        format.html { redirect_to @speck, notice: 'Speck was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @speck.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /specks/1
  # DELETE /specks/1.json
  def destroy
    @speck = Speck.find(params[:id])
    @speck.destroy

    respond_to do |format|
      format.html { redirect_to specks_url }
      format.json { head :no_content }
    end
  end
end
