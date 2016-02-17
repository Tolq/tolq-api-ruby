require 'test_helper'

class Tolq::ApiTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Tolq::Api::VERSION
  end
end
