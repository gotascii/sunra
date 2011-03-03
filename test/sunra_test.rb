require File.expand_path(File.join(File.dirname(__FILE__), 'test_helper'))

class App < Sunra::Base
  get "/" do
    "Hello World"
  end
end

class SunraTest < MiniTest::Unit::TestCase
  def test_should_successfully_get
    get("/")
    assert_body "Hello World"    
  end
end
