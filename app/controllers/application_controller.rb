class ApplicationController < ActionController::Base
  protect_from_forgery
  @open_dataset = nil
  @@open_ds = nil
end
