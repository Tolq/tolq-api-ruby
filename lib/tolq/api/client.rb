module Tolq
  module Api
    # Client handles and encapsulates API requests
    class Client
      attr_reader :key, :secret

      def initialize(key, secret)
        @key = key
        @secret = secret
      end

      def translation_requests
        TranslationRequestApi.new(self)
      end
    end
  end
end
