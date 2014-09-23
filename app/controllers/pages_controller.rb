class PagesController < ApplicationController
  before_filter :user_datasets
  def home
    if !user_signed_in?
      redirect_to action: 'index' and return
    end

    session[:current_dataset_id]=nil

    session[:test]="TEST"

    @locations=[]
    @datasets.each do |d|
      d.locations.each do |loc|
        @locations << loc
      end
    end
    map
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @datasets }
    end
  end
  def help
  end
  def index
    session[:current_dataset_id]=nil
    render :layout => false
  end
  def map
    @hash = Gmaps4rails.build_markers(@locations.uniq) do |location, marker|
      if location.latitude!="" && location.latitude && location.longitude!="" && location.longitude
        marker.lat location.latitude 
        marker.lng location.longitude
        marker.picture({:url => select_marker(location), :height => 34, :width => 34})
        marker.infowindow render_to_string(:partial => "/locations/home_infowindow", :locals => { :location => location })
      end
      @hash.delete_if{|elem| elem.blank?} if @hash
    end
  end
  def user_datasets
    @datasets = current_user.datasets if current_user
  end
  def select_marker(location)
    if location.get_dataset_ids(current_user).length == 1
      marker = Dataset.find(location.get_dataset_ids(current_user).first).auto_marker_icon(current_user)
    else
      marker = "/images/folder_closed.png"
    end
    marker
  end
end