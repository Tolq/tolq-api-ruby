module Tolq
  module Api
    class TranslationRequest
      attr_reader :id,
                  :source_language_code,
                  :target_language_code,
                  :status,
                  :errors,
                  :name,
                  :slug,
                  :quality,
                  :created_at,
                  :callback_url,
                  :completed_at

      def initialize(hash)
        set_attrs(hash)
      end

      private

      def set_attrs(hash)
        hash.each do |key, val|
          instance_variable_set("@#{key}", val)
        end
      end
    end
  end
end
