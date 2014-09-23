class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_dataset
    @current_dataset ||= session[:current_dataset_id] &&
      Dataset.find_by_id(session[:current_dataset_id])
  end
end
