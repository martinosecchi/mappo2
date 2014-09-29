class LocationsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :user_datasets
  before_filter :current_dataset
  before_filter :check_user, :only => [:show, :edit, :destroy]
  # GET /locations
  # GET /locations.json
  def check_user
    unless current_user.locations.include? @location
      redirect_to root_path
    end
  end
  def index
    @locations = Location.find(:all, :order => :name)    
    check_locations(@locations)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @locations }
    end
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
    @location = Location.find(params[:id])

    @hash = Gmaps4rails.build_markers(@location) do |location, marker|
      if location.latitude!=nil && location.longitude!=nil 
        marker.lat location.latitude
        marker.lng location.longitude
        marker.infowindow render_to_string(:partial => "/locations/infowindow", :locals => { :location => location })
      end
    end
    @hash.delete_if{|elem| elem.blank?} if @hash

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @location }
    end
  end
  # GET /locations/new
  # GET /locations/new.json
  def new
    @location = Location.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @location }
    end
  end

  # GET /locations/1/edit
  def edit
    @location = Location.find(params[:id])
  end

  # POST /locations
  # POST /locations.json
  def create
    @location = Location.new(params[:location])

    respond_to do |format|
      if @location.save
        format.html { redirect_to @location, notice: 'Location was successfully created.' }
        format.json { render json: @location, status: :created, location: @location }
      else
        format.html { render action: "new" }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /locations/1
  # PUT /locations/1.json
  def update
    @location = Location.find(params[:id])

    respond_to do |format|
      if @location.update_attributes(params[:location])
        format.html { redirect_to @location, notice: 'Location was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @locations= Location.all
    @location = Location.find(params[:id])
    @location.destroy

    check_locations(@locations) #ne approfitto per fare un controllo ed eventualmente fare un po' di pulizia se serve

    respond_to do |format|
      format.html { redirect_to url_for current_dataset }
      format.json { head :no_content }
    end
  end

  def check_locations(locations) #elimina locations non collegate a works
    locations.each do |loc|
      if loc.works.length==0
        loc.destroy
      end
    end
  end

  def user_datasets
    @datasets = current_user.datasets if current_user
  end
end
