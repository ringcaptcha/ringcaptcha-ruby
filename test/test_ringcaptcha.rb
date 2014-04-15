gem "minitest" 
require 'minitest/autorun'
require '../lib/ringcaptcha'

class TestRingCaptcha < MiniTest::Test
	def setup
      @ringcaptcha = RingCaptcha::RingCaptcha.new("appkey","secretkey")
    end

    def test_verifyInvalidAppKey
      assert_equal "ERROR_INVALID_APP_KEY", @ringcaptcha.is_valid?("pin","token").message
    end
end