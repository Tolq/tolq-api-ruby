module Tolq
  module Api
    # Handles all requests dealing with translation requests
    class TranslationRequestApi
      # Creats a new Tolq::Api::ResponseApi.
      #
      # Called indirectly via Client#translation_requests
      #
      # You should check the 'errors' method on the translation request.
      # Our API returns helpful validation errors if there are any.
      def initialize(client)
        @client = client
      end

      # Creates and orders a new translation request
      #
      # @param request [Hash] A hash consisting of a translation request, this maps 1:1 with the JSON request format. See our documentation for details
      # @return [Tolq::Api::Response] A Tolq::Api::Response with an id, status and some metadata
      def create(request)
        @client.post('/translations/requests', request)
      end

      # Retrieves a translation request
      #
      # @param id [Integer] An id referencing a translation request
      # @return [Tolq::Api::Response] A Tolq::Api::Response with an id, status and some metadata, if completed the translations are also included
      def show(id)
        @client.get("/translations/requests/#{id}")
      end

      # Creates but doesn't order a new translation request
      #
      # @param request [Hash] A hash consisting of a translation request, this maps 1:1 with the JSON request format. See our documentation for details
      # @return [Tolq::Api::Response] A Tolq::Api::Response with an id, status and some metadata
      def quote(request)
        @client.post('/translations/requests/quote', request)
      end

      # Lists all your translation requests
      #
      # @return [Tolq::Api::Response] A list of translation requests without translations
      def list
        @client.get('/translations/requests')
      end

      # Orders a translation request
      #
      # @param id [Integer] An id referencing a translation request
      # @return [Tolq::Api::Response] A Tolq::Api::Response with an id, status and some metadata
      def order(id)
        @client.post("/translations/requests/#{id}/order")
      end

      # Deletes a translation request
      #
      # @param id [Integer] An id referencing a translation request
      # @return [true,false] A boolean indicating success
      def delete(id)
        @client.delete("/translations/requests/#{id}")
      end
    end
  end
end
