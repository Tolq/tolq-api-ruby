require 'test_helper'

module Tolq
  module Api
    class TranslationRequestApiTest < MiniTest::Test
      def setup
        @valid_attrs = {
          'request' => {
            'a.key' => {
              'text' => 'A sentence to translate'
            }
          },
          'source_language_code' => 'en',
          'target_language_code' => 'nl',
          'quality' => 'standard',
          'options' => {
            'name' => 'My translation request',
            'callback_url' => 'https://mysite.com/translations_finished'
          }
        }

        @test_client = TestClient.new
        @api = TranslationRequestApi.new(@test_client)
      end

      ## Creating requests
      def test_creates_a_request
        result = @api.create(@valid_attrs)

        assert result.is_a?(TranslationRequest)
        assert_equal result.id, 1
        assert_equal result.status, 'pending'
        assert_equal @test_client.received,
                     path: '/translations/requests',
                     data: @valid_attrs
      end

      # test formatting errors, user errors
    end
  end
end
