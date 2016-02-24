module Tolq
  module Api
    class TranslationRequest
      attr_reader :id,
                  :callback_url,
                  :completed_at,
                  :created_at,
                  :errors,
                  :name,
                  :orders,
                  :original,
                  :quality,
                  :slug,
                  :source_language_code,
                  :status,
                  :target_language_code,
                  :total_orders,
                  :total_cost,
                  :total_keys,
                  :translations

      def initialize(hash)
        set_attrs(hash)
        @errors ||= []
      end

      private

      def set_attrs(hash)
        hash.each do |key, val|
          instance_variable_set("@#{key}", val)
        end

        if (hash[:errors] || []).any?
          @status = 'error'
        end
      end
    end
  end
end
