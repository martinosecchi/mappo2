class PagesController < ApplicationController
  def home
  	@datasets = Dataset.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @datasets }
    end
  end
  def howto
  end
end