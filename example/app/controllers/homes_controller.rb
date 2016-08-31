require 'pp'

class HomesController < ApplicationController
  require 'ringcaptcha'
  skip_before_filter :verify_authenticity_token

  def index
  end

  # method to call ringcaptcha methods.
  def valid_rc
    rcap = RingCaptcha::RingCaptcha.new(ENV['RING_CAPTCHA_APP_KEY'], ENV['RING_CAPTCHA_SECRET_KEY'])

    @validation = rcap.validate_pin_code(params[:pin_code], params[:token])

    pp @validation

    render json: @validation
  end

end
