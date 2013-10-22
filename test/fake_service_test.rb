require File.expand_path '../test_helper.rb', __FILE__

class FakeServiceTest < MiniTest::Unit::TestCase
  include Rack::Test::Methods
  FakeService.set(:file_path, File.expand_path('../test.yml', __FILE__))

  def app
    FakeService
  end

  def valid_header
    {"CONTENT_TYPE" => 'application/json',
     'ACCEPT' => "application/json",
     'HTTP_AUTHORIZATION' => "Token token=\"14d75ec70594d026de22f02502e74be9\""}
  end

  def valid_body
    '{"name":"Bar","description":"FooBar"}'
  end

  def test_retuning_right_code
    post '/v1/foos', valid_body, valid_header
    assert_equal 201, last_response.status
  end

  def test_retuning_right_code_json_independet_place
    post '/v1/foos', '{"description":"FooBar","name":"Bar"}', valid_header
    assert_equal 201, last_response.status
  end

  def test_reject_if_body_not_match
    post '/v1/foos', '{"description":"FooBar"}', valid_header
    assert_equal 404, last_response.status
  end

  def test_returns_body
    post '/v1/foos', valid_body, valid_header
    expected = '{"id":974435878,"name":"Bar","description":"FooBar"}'
    assert_equal expected, last_response.body
  end

  def test_wrong_authorization_header
    header = valid_header.merge("HTTP_AUTHORIZATION" => "123")
    post '/v1/foos', valid_body, header
    assert_equal 404, last_response.status
  end

  def test_wrong_authorization_header
    header = valid_header.merge("HTTP_AUTHORIZATION" => "123")
    post '/v1/foos', valid_body, header
    assert_equal 404, last_response.status
  end
end