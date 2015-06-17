require 'bundler/setup'
require 'databox'
require 'yaml'
require 'active_record'
require 'activerecord-import'
require 'dotenv'
Dotenv.load

ENV["DRS_ENV"] ||= "development"

Databox.configure do |c|
  c.push_token = ENV["DATABOX_PUSH_TOKEN"]
end

ActiveRecord::Base.logger = Logger.new("log/#{ENV['DRS_ENV']}.log")
ActiveRecord::Base.logger.level = Logger::DEBUG

DB_CONFIG = YAML::load(File.open('./config/database.yml'))
ActiveRecord::Base.establish_connection(DB_CONFIG[ENV["DRS_ENV"]])
ActiveRecord::Base.schema_format = :sql
require_relative './price.rb'
