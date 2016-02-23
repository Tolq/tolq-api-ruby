module Tolq
  module Api
    # Client handles and encapsulates API requests
    class Client
      BASE_URL = 'https://%{key}:%{secret}@api.tolq.com/v1'.freeze
      attr_reader :key, :secret

      def initialize(key, secret)
        @key = key
        @secret = secret
      end

      def translation_requests
        TranslationRequestApi.new(self)
      end

      def get(path, data = nil)
        response = do_request(:get, path, data)
        handle_response(response)
      end

      def post(path, data = nil)
        response = do_request(:post, path, data)
        handle_response(response)
      end

      def delete(path, data = nil)
        response = do_request(:delete, path, data)
        handle_response(response)
      end

      def put(path, data = nil)
        response = do_request(:put, path, data)
        handle_response(response)
      end

      private

      def base_url
        BASE_URL % { key: key, secret: secret }
      end

      def do_request(method, path, data = nil)
      end

      def handle_response(response)
        case response.code.to_i
        when 200..201
          JSON.parse(response.body)
        when 422
          JSON.parse(response.body)
        else
          { errors: ["Unexpected response: #{response.code}"] }
        end
      end
    end
  end
end
