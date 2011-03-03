$:.unshift File.join(File.dirname(__FILE__), '..')

require "rubygems"
require "bundler/setup"
require "sunra"
require "rack/test"
require "minitest/autorun"

class MiniTest::Unit::TestCase
  include Rack::Test::Methods
  
  def app
    @app ||= self.class.const_get(:App).to_app
  end
  
  def assert_body(body)
    assert_equal body, last_response.body
  end
end