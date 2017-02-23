require 'open-uri'
require 'net/http'
require 'json'
require 'ostruct'

module RingCaptcha
  class RingCaptchaRequestError < StandardError; end

  class RingCaptchaVerification

    extend Forwardable
    PUBLIC_METHODS = [:status, :message, :transaction_id, :phone,  :geolocation, :phone_type, :carrier_name, :roaming, :risk, :json]

    PUBLIC_METHODS.each do |m|
      def_delegators :@json, m
    end

    def initialize(json)
      @json = OpenStruct.new(json)
    end

    def valid?
      status == "SUCCESS"
    end

    def as_json(options={})
      @json.to_h.slice(*PUBLIC_METHODS)
    end
  end

  class RingCaptcha
    @@rc_server     = 'api.ringcaptcha.com'
    @@user_agent    = 'ringcaptcha-ruby/1.0'

    attr_accessor :secure

    def initialize(app_key, secret_key)
      @app_key = app_key
      @secret_key = secret_key
      @retry_attempts = 0
      @secure = true
      @status = -1
    end

    def validate_pin_code(pin_code, token)
      #TODO Check parameters
      data = {:secret_key => @secret_key, :token => token, :code => pin_code}
      sanitize_data(data)
      server = (@secure ? "https://" : "http://") + @@rc_server
      resource = "#{@app_key}/verify"
      begin
        response = verify_rest_call(server, resource, data)
        body = JSON.parse(response.body)
        @status = response.class.name == "Net::HTTPOK" ? body['status'] == "SUCCESS" : 0
      rescue => e
        @status = 0
        @message = e.message
      end

      return RingCaptchaVerification.new(body)
    end

    def is_valid?(pin_code, token)
      validate_pin_code(pin_code, token)
      @status == true
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
