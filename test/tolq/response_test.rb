require 'test_helper'

module Tolq
  module Api
    class ResponseTest < MiniTest::Test
      test 'new from create response' do
        body = {
          'source_language_code' => 'en',
          'target_language_code' => 'nl',
          'status' => 'pending',
          'id' => 1,
          'quality' => 'standard',
          'name' => 'My translation request',
          'slug' => 'my-translation-request',
          'callback_url' => 'https://mysite.com/translations_finished'
        }

        request = Response.new(status: 201, body: body.to_json)
        assert_equal request.status, 201
        assert_equal request.body, body.to_json
      end

      test 'works with errors' do
        error_response = {
          errors: ['Error one', 'Error two']
        }

        request = Response.new(status: 422, body: error_response.to_json)

        assert_equal request.status, 422
        assert_equal request.body, error_response.to_json
      end
    end
  end
end
