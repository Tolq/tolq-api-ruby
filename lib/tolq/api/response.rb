module Tolq
  module Api
    # Wraps the responses of the Tolq Api
    class Response
      attr_reader :status, :body

      def initialize(status:, body:)
        raise ArgumentError.new('Expected body to be a string') unless !body || body.is_a?(String)

        @status = status.to_i
        @body = body
      end

      def ==(other)
        self.status == other.status && self.body == other.body
      end
    end
  end
end
