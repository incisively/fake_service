require 'yaml'
require 'sinatra/base'
require 'json'
require File.expand_path '../middleware', __FILE__

module FakeService
  class Server < Sinatra::Base
    #set this attribute from runner
    #set :file_path, path_to_file

    use Middleware

    # Checks for bodies equality. json bodies keys can have different orders.
    def equal_json_bodies?(expected_body, body)
      JSON.parse(expected_body) == JSON.parse(body)
    end

    # Checks for request comes with right header.
    def right_header?(expected, actual)
      expected.inject(true) do |memo, (k, v)|
        memo && v == actual[k]
      end
    end

    # define action.
    def self.define_action!(expected_request, expected_response)
      action = expected_request["method"].downcase
      url = expected_request["full_path"]
      send(action, url, provides: :json) do
        pass unless right_header?(expected_request["headers"], request.env)
        pass unless equal_json_bodies?(expected_request["body"], request.body.read)
        headers expected_response["headers"]
        status expected_response["code"]
        expected_response["body"]
      end
    end
  end
end