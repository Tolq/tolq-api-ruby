require 'test_helper'

module Tolq
  module Api
    class IntegrationTest < Minitest::Test
      def setup
        @client = Client.new('abc', 'xyz')
        @base_uri = "https://abc:xyz@api.tolq.com/v1"
      end

      test 'creating a translation request' do
        request_body = {
          request: {
            'a.key' => {
              text: 'Translate me please'
            }
          },
          source_language_code: 'nl',
          target_language_code: 'en',
          quality: 'standard',
          options: {
            name: 'I like bacon',
            context_url: 'http://www.tolq.com'

          }
        }

        stub_request(:post, "#{@base_uri}/translations/requests")
          .with(body: request_body.to_json, headers: { 'Content-Type' => 'application/json' })
          .to_return(status: 201, body: load_fixture('/integration/create.json'))

        response = @client.translation_requests.create(request_body)

        assert response.is_a?(TranslationRequest)
        assert response.id.is_a?(Integer)
        assert_equal response.status, 'pending'
        assert_equal response.errors, []
        assert_equal response.quality, 'standard'
      end

      test 'quoting a translation request' do
        request_body = {
          request: {
            'a.key' => {
              text: 'Translate me please'
            }
          },
          source_language_code: 'nl',
          target_language_code: 'en',
          quality: 'standard',
          options: {
            name: 'I like bacon',
            context_url: 'http://www.tolq.com'

          }
        }

        stub_request(:post, "#{@base_uri}/translations/requests/quote")
          .with(body: request_body.to_json, headers: { 'Content-Type' => 'application/json' })
          .to_return(status: 201, body: load_fixture('/integration/create.json'))

        response = @client.translation_requests.quote(request_body)

        assert response.is_a?(TranslationRequest)
        assert response.id.is_a?(Integer)
        assert_equal response.status, 'pending'
        assert_equal response.errors, []
        assert_equal response.quality, 'standard'
      end

      test 'listing translation requests' do
        stub_request(:get, "#{@base_uri}/translations/requests")
          .with(headers: { 'Content-Type' => 'application/json' })
          .to_return(status: 200, body: load_fixture('/integration/list.json'))

        response = @client.translation_requests.list

        assert response.is_a?(Array)
        assert response.length == 2
        tr1 = response[0]
        tr2 = response[1]
        assert_equal tr1.id, 1
        assert tr1.is_a?(TranslationRequest)
        assert_equal tr2.id, 2
        assert tr2.is_a?(TranslationRequest)
      end

      test 'ordering a quote' do
        stub_request(:post, "#{@base_uri}/translations/requests/1/order")
          .with(body: nil, headers: { 'Content-Type' => 'application/json' })
          .to_return(status: 201, body: load_fixture('/integration/order.json'))

        response = @client.translation_requests.order(1)

        assert response.is_a?(TranslationRequest)
        assert response.id.is_a?(Integer)
        assert_equal response.status, 'in_translation'
        assert_equal response.errors, []
        assert_equal response.quality, 'standard'
      end

      test 'deleting a quote' do
        stub_request(:delete, "#{@base_uri}/translations/requests/1")
          .with(body: nil, headers: { 'Content-Type' => 'application/json' })
          .to_return(status: 200)

        response = @client.translation_requests.delete(1)

        assert_equal response, true
      end

      test 'showing a quote' do
        stub_request(:get, "#{@base_uri}/translations/requests/1")
          .with(body: nil, headers: { 'Content-Type' => 'application/json' })
          .to_return(status: 201, body: load_fixture('/integration/get.json'))

        response = @client.translation_requests.show(1)

        assert response.is_a?(TranslationRequest)
        assert response.id.is_a?(Integer)
        assert_equal response.status, 'in_translation'
        assert_equal response.errors, []
        assert_equal response.quality, 'standard'
      end

      test 'showing a request with translations' do
        stub_request(:get, "#{@base_uri}/translations/requests/1")
          .with(body: nil, headers: { 'Content-Type' => 'application/json' })
          .to_return(status: 201, body: load_fixture('/integration/get_translations.json'))

        response = @client.translation_requests.show(1)

        assert response.is_a?(TranslationRequest)
        assert_equal response.id, 1
        assert_equal response.status, 'finished'
        assert_equal response.errors, []
        assert_equal response.quality, 'machine'
        assert_equal response.total_orders, 1
        assert_equal response.total_cost, 0.0
        assert_equal response.total_keys, 2
        assert_equal response.orders, [
          { "quality" => "machine", "target_language_code" => "tq", "status" => "finished"}
        ]
        assert_equal response.translations, {
          "tq" => {
            "a.key" => "omesay exttay otay anslatetray",
            "b.key" => "ywhay areay ananasbay ookedcray"
          }
        }
        assert_equal response.original, {
          "a.key" => "some text to translate",
          "b.key" => "why are bananas crooked"
        }
      end
    end
  end
end
