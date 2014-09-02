class PagesController < ApplicationController
  #before_filter :authenticate_user!, :only => [:home]
  def home
    if !user_signed_in?
      redirect_to action: 'index' and return
    end

  	@datasets = current_user.datasets
    #@datasets = Dataset.all
  	@open_dataset = nil
    @@open_ds = nil

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @datasets }
    end
  end
  def help
  end
  def index
  end
end