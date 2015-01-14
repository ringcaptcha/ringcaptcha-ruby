class HomesController < ApplicationController
require 'ringcaptcha'
skip_before_filter :verify_authenticity_token  
  
  # method to call ringcaptcha methods.
  def valid_rc
      rcap = RingCaptcha::RingCaptcha.new('apo8amopuco7onaku5u7', 'o6i8e1e6yze3u8y1iji7')
      @rcap_valid = rcap.is_valid?(params[:param1], params[:params2])
      respond_to do |format|
        format.js 
      end

  end

end
