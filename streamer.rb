#!/usr/bin/env ruby
# encoding: UTF-8

require_relative './boot.rb'

puts "Streamer. Up."

class PriceStreamer
  attr_accessor :price, :client
  def initialize(price={}, client=Databox::Client.new)
    self.client = client
    self.price = price.is_a?(Hash) ? Price.new(price) : price
  end

  def stream
    puts self.client.push(
      "ruby.oilprice",
      self.price.volume,
      self.price.date
    ) ? "#{self} to SQL → Databox ✓" : "Error inserting! ✘"
  end

  def to_s
    self.price.to_s
  end
end

ActiveRecord::Base.connection_pool.with_connection do |connection|
  c = connection.instance_variable_get(:@connection)

  begin
    c.async_exec "LISTEN pricesinserted"

    loop do
      c.wait_for_notify do |channel, _, payload|
        return if channel != "pricesinserted"
        PriceStreamer.new(JSON.load(payload)).stream
      end
    end
  ensure
    c.async_exec "UNLISTEN *"
  end
end
