require 'net/https'

module Tolq
  module Api
    # Client handles and encapsulates API requests
    class Client
      BASE_URL = 'https://%{key}:%{secret}@api.tolq.com/v1'.freeze
      attr_reader :key, :secret

      # Creates a client to interface with the Tolq API.
      #
      # @param key [String] Your API key
      # @param secret [String] Your API secret
      def initialize(key, secret)
        @key = key
        @secret = secret
      end

      # Via this method you can make requests to the Tolq API
      #
      # @return [TranslationRequestApi] An interface for making api requests.
      def translation_requests
        TranslationRequestApi.new(self)
      end

      # Verifies a signature on a callback payload
      # You can find the signature in the X-Tolq-Signature
      # header
      #
      # @param signature [String] A sha1 encoded HMAC signature including the 'sha1=' prefix
      # @param payload [String] The body of the payload as a string
      def valid_signature?(signature, payload)
        payload_signature = 'sha1=' + OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha1'), self.key, payload)
        payload_signature == signature
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
        # TODO remove interpolation
        # not needed with Net::HTTP
        BASE_URL % { key: key, secret: secret }
      end

      def do_request(method, path, data = nil)
        uri = URI.parse(base_url + path)
        https = Net::HTTP.new(uri.host, uri.port)
        https.use_ssl = true

        request =
          case method
          when :post
            Net::HTTP::Post.new(uri.path)
          when :get
            Net::HTTP::Get.new(uri.path)
          when :delete
            Net::HTTP::Delete.new(uri.path)
          end

        request.body = data.to_json if data
        request.basic_auth @key, @secret
        request['Content-Type'] = 'application/json'

        https.request(request)
      end

      def handle_response(response)
        Response.new(status: response.code.to_i, body: response.body)
      end
    end
  end
end
