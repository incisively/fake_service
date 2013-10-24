ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'
require 'minitest/pride'
require 'test/unit'
require 'rack/test'
require 'byebug'

require File.expand_path '../../lib/fake_service.rb', __FILE__