$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'tolq/api'

require 'minitest/autorun'
Dir[File.dirname(__FILE__) + '/support/*.rb'].each { |file| require file }
