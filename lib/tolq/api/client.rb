module Tolq::Api
  class Client
    attr_reader :key, :secret

    def initialize(key, secret)
      @key, @secret = key, secret
    end

    def translation_requests
      TranslationRequest.new(self)
    end
  end
end
