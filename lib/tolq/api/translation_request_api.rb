module Tolq
  module Api
    # Handles all requests dealing with translation
    # requests
    class TranslationRequestApi
      def initialize(client)
        @client = client
      end

      def create(hash)
        response = @client.post('/translations/requests', hash)
        TranslationRequest.new(response)
      end

      def quote(hash)
        response = @client.post('/translations/requests/quote', hash)
        TranslationRequest.new(response)
      end

      def list
        response = @client.get('/translations/requests')
        response.map { |tr| TranslationRequest.new(tr) }
      end

      def order(id)
        response = @client.post("/translations/requests/#{id}/order")
        TranslationRequest.new(response)
      end

      def delete(id)
        response = @client.delete("/translations/requests/#{id}")
        if response[:errors].any?
          false # TODO meaningful errors
        else
          true
        end
      end
    end
  end
end
