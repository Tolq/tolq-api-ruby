require 'test_helper'

module Tolq
  module Api
    class ClientTest < Minitest::Test
      class FakeResponse < Struct.new(:code, :body); end

      def setup
        @client = Client.new('abc', 'xyz')
      end

      test 'setting key and secret' do
        assert_equal @client.key, 'abc'
        assert_equal @client.secret, 'xyz'
      end

      test 'base url' do
        assert_equal @client.send(:base_url), 'https://abc:xyz@api.tolq.com/v1'
      end

      test 'hmac signature check' do
        payload = "{ 'hello': 'world' }"
        refute @client.valid_signature?('badsignature', payload)

        good_signature = 'sha1=' + OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha1'), @client.key, payload)
        assert @client.valid_signature?(good_signature, payload)
      end

      # DRY tests to verify client works as expected
      { get: 200, post: 201, delete: 200, put: 200 }.each do |verb, code|
        test "#{verb} succesful request" do
          response_body = load_fixture("client/#{verb}.json")
          stub_request(code, response_body) do
            assert_equal @client.send(verb, '/test'), Response.new(status: code, body: response_body)
          end
        end

        test "#{verb} server side errors" do
          stub_request(301) do
            assert_equal @client.send(verb, '/test'), Response.new(status: 301, body: nil)
          end

          stub_request(400) do
            assert_equal @client.send(verb, '/test'), Response.new(status: 400, body: nil)
          end

          stub_request(500) do
            assert_equal @client.send(verb, '/test'), Response.new(status: 500, body: nil)
          end
        end

        test "#{verb} user input error" do
          response_body = load_fixture('client/user_error.json')
          stub_request(422, response_body) do
            assert_equal @client.send(verb, '/test'), Response.new(status: 422, body: response_body)
          end
        end

      end

      def stub_request(response_code, response_body = nil)
        stub = FakeResponse.new response_code.to_s, response_body
        @client.stub :do_request, -> (*args) { stub } do
          yield
        end
      end
    end
  end
end


