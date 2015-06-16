require 'bundler/setup'
require 'databox'
require 'yaml'
require 'active_record'

ENV["DRS_ENV"] ||= "development"

Databox.configure do |c|
  c.push_token = ENV["DATABOX_PUSH_TOKEN"]
end

DB_CONFIG = YAML::load(File.open('./config/database.yml'))
ActiveRecord::Base.establish_connection(DB_CONFIG[ENV["DRS_ENV"]])

require_relative 'price.rb'
