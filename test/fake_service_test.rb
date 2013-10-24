require File.expand_path '../test_helper.rb', __FILE__

class FakeServiceTest < MiniTest::Unit::TestCase
  include Rack::Test::Methods
  FakeService::Server.set(:file_path, File.expand_path('../test.yml', __FILE__))

  def app
    FakeService::Server
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

  def test_wrong_accept
    header = valid_header.merge("ACCEPT" => "123")
    post '/v1/foos', valid_body, header
    assert_equal 404, last_response.status
  end

  def test_wrong_content_type
    header = valid_header.merge("CONTENT_TYPE" => "123")
    post '/v1/foos', valid_body, header
    assert_equal 404, last_response.status
  end

  def test_when_one_header_is_missing
    header = valid_header.delete_if { |k, v| k =="HTTP_AUTHORIZATION" }
    post '/v1/foos', valid_body, header
    assert_equal 404, last_response.status
  end

  def test_haders_in_responce
    post '/v1/foos', valid_body, valid_header
    headers = {
        "X-Frame-Options" => "SAMEORIGIN",
        "X-XSS-Protection" => "1; mode=block",
        "X-Content-Type-Options" => "nosniff",
        "X-UA-Compatible" => "chrome=1",
        "Location" => "http://www.example.com/v1/foos",
        "Content-Type" => "text/html; charset=utf-8",
        "ETag" => "\"3ac3a959a1a3466cd1a1e4f5939e339b\"",
        "Cache-Control" => "max-age=0, private, must-revalidate",
        "X-Request-Id" => "45efbba1-a3b9-4651-81a3-819290570a80",
        "X-Runtime" => "0.028181",
        "Content-Length" => "52"
    }
    assert_equal headers, last_response.headers
  end
end