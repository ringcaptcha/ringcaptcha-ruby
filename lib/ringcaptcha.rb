require "ringcaptcha/version"
require 'open-uri'
require 'net/http'

module RingCaptcha
  class RingCaptchaRequestError < StandardError; end

  class RingCaptcha
    @@rc_server     = 'api.ringcaptcha.com'
    @@user_agent    = 'ringcaptcha-ruby/1.0'    
    
    attr_reader :status, :message, :transaction_id, :phone_number,  :geolocation, 
                :phone_type, :carrier_name, :device_name, :isp_name
    attr_accessor :secure
    def initialize(app_key, secret_key)
    	@app_key = app_key
    	@secret_key = secret_key
      @retry_attempts = 0
      @secure = true
      @status = -1
    end

    def is_valid?(pin_code, token)
      #TODO Check parameters
      data = {secret_key: @secret_key, token: token, code: pin_code}
      sanitize_data(data)
      server = (@secure ? "https://" : "http://") + @@rc_server
      resource = "#{@app_key}/verify"
      begin
        response = verify_rest_call(server, resource, data)
        puts response.inspect
        @status = response.class.name == "Net::HTTPOK" ? 1 : 0
      rescue => e
        @status = 0
        @message = e.message 
        return false
      end

      {"id" => @transaction_id,
       "phone" => @phone_number,
       "geolocation" => @geolocation,
       "message" => @message,
       "phone_type" => @phone_type,
       "carrier" => @carrier_name,
       "device" => @device_name,
       "isp" => @isp_name}.each do |key,var|
        var = response.to_hash.has_key?(key) ? response.to_hash[key] : false
       end
      @status == 1

    end

  private

    def sanitize_data(data)
      data.each do |key,value|
        data[key] = URI::encode(value).strip
      end
    end

    def verify_rest_call(server, resource, data, port=80)
      port = @secure ? 443 : port
      url = "#{server}:#{port}/#{resource}"
      
      uri = URI.parse(url)
      https = Net::HTTP.new(uri.host,uri.port)
      https.use_ssl = @secure
      req = Net::HTTP::Post.new(uri.path, initheader = {'User-Agent' => @@user_agent})
      req.set_form_data(data)
      res = https.request(req)

      case res
        when Net::HTTPSuccess, Net::HTTPRedirection
          res
        else
          raise RingCaptchaRequestError, 'ERROR_PROCESING_REQUEST'
      end

    end
  end
end
