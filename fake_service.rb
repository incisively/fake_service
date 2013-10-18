require "yaml"
require "byebug"
require 'sinatra/base'

class FakeService < Sinatra::Base

  def initialize(yaml_file = nil, app = nil)
    file_path = yaml_file || File.expand_path('../reqres.yml', __FILE__)
    self.class.define_actions(file_path)
    super(app)
  end

  def self.define_actions(file_path)
    hash = YAML.load(File.read(file_path))

    hash.each do |k, v|
      v.each do |key, value|
        expected_request = value["request"]
        expected_response = value["response"]
        puts expected_request["method"].downcase
        puts expected_request["full_path"]
        send(expected_request["method"].downcase, expected_request["full_path"], provides: :json) do
          pass unless expected_request["body"] == request.body.read
          expected_response["body"]
          status expected_response["code"]
        end
      end
    end
  end


  run! if app_file == $0
end

