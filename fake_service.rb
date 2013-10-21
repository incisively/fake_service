require "yaml"
require "byebug"
require 'sinatra/base'
require "json"
require "./fake_middleware"

class FakeService < Sinatra::Base
  use FakeMiddleware


  def equal_json_bodies?(expected_body, body)
    #puts expected_body
    #puts body
    #puts self
    #puts self.inspect
    JSON.parse(expected_body) == JSON.parse(body)
  end

  run! if app_file == $0
end

