class ApplicationController < ActionController::Base
  require 'time'
  protect_from_forgery
  def download
    send_file(Rails.public_path + params[:path], :disposition => 'inline')
  end

  def get_time
    time_response = "get_time=#{Time.now.to_i}"
    respond_to do |format|
      format.text { render text: time_response, status: :ok }
    end
  end

  def get_outdoor_aqi
    aqi_response = "get_outdoor_aqi=-1"
    respond_to do |format|
      format.text { render text: aqi_response, status: :ok }
    end
  end

  def get_message
    message_response = "message=NULL"
    respond_to do |format|
      format.text { render text: message_response, status: :ok }
    end
  end

  def get_scaler
    scaler_response = "get_scaler=408"
    respond_to do |format|
      format.text { render text: scaler_response, status: :ok }
    end
  end

end
