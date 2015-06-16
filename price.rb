require 'json'
require 'net/http'

class Price < ActiveRecord::Base

  def self.all_from_ws(prices_json_path="./prices.json", start="2000-01-01")
    prices_raw = if File.exists?(prices_json_path)
      IO.read prices_json_path
    else
      prices_str = Net::HTTP.get(URI("https://www.quandl.com/api/v1/datasets/OPEC/ORB.json?trim_start=#{start}"))
      File.write(prices_json_path, prices_str)
      prices_str
    end

    JSON.load(prices_raw)["data"].map { |p| Price.new(date: p[0], volume: p[1]) }
  end
end
