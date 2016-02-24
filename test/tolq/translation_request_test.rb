require 'test_helper'

module Tolq
  module Api
    class TranslationRequestTest < MiniTest::Test
      test 'new from create response' do
        create_response = {
          'source_language_code' => 'en',
          'target_language_code' => 'nl',
          'status' => 'pending',
          'id' => 1,
          'quality' => 'standard',
          'name' => 'My translation request',
          'slug' => 'my-translation-request',
          'callback_url' => 'https://mysite.com/translations_finished'
        }

        request = TranslationRequest.new(create_response)
        create_response.keys.each do |key|
          assert_equal request.send(key), create_response[key]
        end
      end

      test 'works with errors' do
        error_response = {
          errors: ['Error one', 'Error two']
        }

        request = TranslationRequest.new(error_response)

        assert_equal request.status, 'error'
        assert_equal request.errors, ['Error one', 'Error two']
      end
    end
  end
end
