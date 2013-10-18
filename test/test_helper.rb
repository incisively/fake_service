ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'
require 'minitest/pride'
require 'test/unit'
require 'rack/test'

require File.expand_path '../../fake_service.rb', __FILE__