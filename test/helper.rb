require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'minitest/unit'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'sunra'

class MiniTest::Unit::TestCase
  include Rack::Test::Methods

  def app
    @app ||= self.class.const_get(:App).to_app
  end
  
  def assert_body(body)
    assert_equal body, last_response.body
  end
end

MiniTest::Unit.autorun