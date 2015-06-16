#!/usr/bin/env ruby
require_relative './boot.rb'

puts "Streamer"

ActiveRecord::Base.connection_pool.with_connection do |connection|
  conn = connection.instance_variable_get(:@connection)

  begin
    conn.async_exec "LISTEN meme"
    conn.async_exec "LISTEN meme_x"

    conn.wait_for_notify do |channel, pid, payload|
      puts "1 Received a NOTIFY on channel #{channel}"
      puts "from PG backend #{pid}"
      puts "saying #{payload}"
    end


    conn.wait_for_notify(0.5) do |channel, pid, payload|
      puts "2 Received a NOTIFY on channel #{channel}"
      puts "from PG backend #{pid}"
      puts "saying #{payload}"
    end

  ensure
    # Don't want the connection to still be listening once we return
    # it to the pool - could result in weird behavior for the next
    # thread to check it out.
    conn.async_exec "UNLISTEN *"
  end
end
