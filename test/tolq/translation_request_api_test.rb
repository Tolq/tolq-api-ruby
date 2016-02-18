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

        @invalid_attrs = {
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

      def test_creates_a_request
        result = @api.create(@valid_attrs)

        assert result.is_a?(TranslationRequest)
        assert_equal result.status, 'pending'
        assert_equal result.id, 1
        assert_equal @test_client.received,
                     path: '/translations/requests',
                     method: :post,
                     data: @valid_attrs
      end

      def test_create_deals_with_errors
        result = @api.create(@invalid_attrs)

        assert result.is_a?(TranslationRequest)
        assert_equal result.id, nil
        assert_equal result.status, 'error'
        assert_equal result.errors.length, 1
        assert_equal @test_client.received,
                     path: '/translations/requests',
                     method: :post,
                     data: @invalid_attrs
      end

      def test_quotes_a_request
        result = @api.quote(@valid_attrs)

        assert result.is_a?(TranslationRequest)
        assert_equal result.status, 'pending'
        assert_equal result.id, 1
        assert_equal @test_client.received,
                     path: '/translations/requests/quote',
                     method: :post,
                     data: @valid_attrs
      end

      def test_quote_deals_with_errors
        result = @api.quote(@invalid_attrs)

        assert result.is_a?(TranslationRequest)
        assert_equal result.id, nil
        assert_equal result.status, 'error'
        assert_equal result.errors.length, 1
        assert_equal @test_client.received,
                     path: '/translations/requests/quote',
                     method: :post,
                     data: @invalid_attrs
      end

      def test_list_all_requests
        results = @api.list

        assert results.is_a?(Array)

        result = results[0]
        assert result.is_a?(TranslationRequest)
        assert_equal result.status, 'in_translation'
        assert_equal result.id, 1
        assert_equal @test_client.received,
                     path: '/translations/requests',
                     method: :get,
                     data: nil
      end

      def test_order_a_quote
        result = @api.order(1)
        assert result.is_a?(TranslationRequest)
        assert_equal result.status, 'in_translation'
        assert_equal result.id, 1
        assert_equal @test_client.received,
                     path: '/translations/requests/1/order',
                     method: :post,
                     data: nil
      end

      def test_delete_a_quote
        result = @api.delete(1)

        assert_equal result, true
        assert_equal @test_client.received,
                     path: '/translations/requests/1',
                     method: :delete,
                     data: nil
      end

      ## Dealing with errors
    end
  end
end
