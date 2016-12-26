$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require 'bundler/setup'
require 'rails'
require "rake_unused_routes"
require 'pry-byebug'
require "simplecov"
require_relative 'app'
SimpleCov.start
