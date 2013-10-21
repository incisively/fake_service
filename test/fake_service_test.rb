require File.expand_path '../test_helper.rb', __FILE__

class FakeServiceTest < MiniTest::Unit::TestCase
  include Rack::Test::Methods



  def app
    FakeService
  end

  def test_retuning_right_code
    post '/v1/foos', '{"name":"Bar","description":"FooBar"}',
         {"CONTENT_TYPE" => 'application/json',
          'ACCEPT' => "application/json"}
    assert_equal 201, last_response.status
  end

  def test_retuning_right_code_json_independet_place
    post '/v1/foos', '{"description":"FooBar","name":"Bar"}',
         {"CONTENT_TYPE" => 'application/json',
          'ACCEPT' => "application/json"}
    assert_equal 201, last_response.status
  end

  def test_reject_if_body_not_match
    post '/v1/foos', '{"description":"FooBar"}',
         {"CONTENT_TYPE" => 'application/json',
          'ACCEPT' => "application/json"}
    assert_equal 404, last_response.status
  end
end