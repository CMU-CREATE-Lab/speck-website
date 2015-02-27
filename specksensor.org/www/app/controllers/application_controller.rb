class ApplicationController < ActionController::Base
  require 'time'
  require "net/https"
  require "uri"

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
    ## Loop through request headers
    #request.headers.each do |key, array|
    #  Rails.logger.info "#{key}-----"
    #  Rails.logger.info array
    #end
    #Rails.logger.info(request.headers['serialnumber'])
    #Rails.logger.info(request.headers['feedapikey'])
    #Rails.logger.info(request.headers['firmware'])

    incoming_seral_number = request.headers['serialnumber']
    firmware = request.headers['firmware']
    current_time = Time.now
    speck = Speck.find_or_create_by_serial_number(incoming_seral_number) do |speck|
      speck.serial_number = incoming_seral_number
    end
    speck.firmware = firmware
    speck.updated_at = current_time
    speck.save

    # Special case for San Fran demo
    demo_speck_serial_number = "3ad7a1ff98b3b59234a70c5de644e330"
    if request.headers['serialnumber'] == demo_speck_serial_number
      begin
        redwood_city_api_key = "32fd98700f32fb3f4b521f0b33020036bda7eebca70453f594397665dd596f19"

        # TODO: This fails on initial day rollover because of the note below
        # NOTE: AirNow reports are usually 2 hours behind
        end_time = current_time
        start_time = end_time.change(:hour => 0, :minute => 0)

        # TODO: Cache values, since AirNow values change every hour and we may be requesting more often
        uri = URI.parse("https://esdr.cmucreatelab.org/api/v1/feeds/#{redwood_city_api_key}/channels/PM2_5/export?from=#{start_time.to_i}&to=#{end_time.to_i}")
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        request = Net::HTTP::Get.new(uri.request_uri)
        response = http.request(request)

        csv_array = response.body.split("\n")
        aqi_value = csv_array.last.split(",").last.to_i
        aqi_value = -1 if aqi_value <= 0
      rescue Exception => e
        Rails.logger.info(e.message)
        aqi_value = -1
      end
    else
      aqi_value = -1
    end
    aqi_response = "get_outdoor_aqi=#{aqi_value}"
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
