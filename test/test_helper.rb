$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'tolq/api'

require 'minitest/autorun'
require 'pry'
Dir[File.dirname(__FILE__) + '/support/*.rb'].each { |file| require file }

def load_fixture(fixname)
  File.open("test/fixtures/#{fixname}", "rb") { |f| f.read }
end

# Methods are uncanny and ask for repetition
# use test name, block instead
class Minitest::Test
  def self.test(name, &block)
    define_method('test_' + name.downcase.gsub(/ /,'_'), block)
  end
end
