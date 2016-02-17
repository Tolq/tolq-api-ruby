require 'test_helper'

module Tolq::Api
  class ClientTest < Minitest::Test
    def setup
      @client = Client.new("abc", "xyz")
    end

    def test_setting_key_and_secret
      assert_equal @client.key, "abc"
      assert_equal @client.secret, "xyz"
    end

    def test_create_translation_request
      # TODO
    end
  end
end
