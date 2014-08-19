class PagesController < ApplicationController
  def home
  	@datasets = Dataset.all
  	@open_dataset = nil

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @datasets }
    end
  end
  def howto
  end
end