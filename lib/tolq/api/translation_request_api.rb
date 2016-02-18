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

      def list; end;
      def quote; end;
      def order; end;
      def delete; end;
    end
  end
end
