module Tolq
  module Api
    # Handles all requests dealing with translation requests
    class TranslationRequestApi
      # Creats a new TranslationRequestApi.
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
      # @return [TranslationRequest] A TranslationRequest with an id, status and some metadata
      def create(request)
        response = @client.post('/translations/requests', request)
        TranslationRequest.new(response)
      end

      # Retrieves a translation request
      #
      # @param id [Integer] An id referencing a translation request
      # @return [TranslationRequest] A TranslationRequest with an id, status and some metadata, if completed the translations are also included
      def show(id)
        response = @client.get("/translations/requests/#{id}")
        TranslationRequest.new(response)
      end

      # Creates but doesn't order a new translation request
      #
      # @param request [Hash] A hash consisting of a translation request, this maps 1:1 with the JSON request format. See our documentation for details
      # @return [TranslationRequest] A TranslationRequest with an id, status and some metadata
      def quote(request)
        response = @client.post('/translations/requests/quote', request)
        TranslationRequest.new(response)
      end

      # Lists all your translation requests
      #
      # @return [Array<TranslationRequest>] A list of translation requests without translations
      def list
        response = @client.get('/translations/requests')
        response.map { |tr| TranslationRequest.new(tr) }
      end

      # Orders a translation request
      #
      # @param id [Integer] An id referencing a translation request
      # @return [TranslationRequest] A TranslationRequest with an id, status and some metadata
      def order(id)
        response = @client.post("/translations/requests/#{id}/order")
        TranslationRequest.new(response)
      end

      # Deletes a translation request
      #
      # @param id [Integer] An id referencing a translation request
      # @return [true,false] A boolean indicating success
      def delete(id)
        response = @client.delete("/translations/requests/#{id}")
        # TODO: meaningful errors
        !(response[:errors] && response[:errors].any?)
      end
    end
  end
end
