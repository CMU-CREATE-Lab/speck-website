class ApplicationController < ActionController::Base
  protect_from_forgery
  def download
    send_file(Rails.public_path + params[:path], :disposition => 'inline')
  end
end
