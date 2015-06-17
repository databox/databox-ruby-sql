# SQL → Databox with Databox Ruby Gem

Answer to the question: How to move data from [PostgreSQL](http://www.postgresql.org/) to Databox with [Databox Ruby Gem / SDK](https://github.com/databox/databox-ruby)?

## Example

This example project contains example on how to create simple [PostgreSQL](http://www.postgresql.org/) database that will hold OPEC oil prices. When new oil price is inserted into `prices` table PostgreSQL triggers `NOTIFY` and asynchronously [streamer.rb](streamer.rb) `LISTEN`s and sends data to Databox.

This are the steps to get you going...

First create new `.env` in current project folder with your `DATABOX_PUSH_TOKEN`.

Create new database, start [PostgreSQL](http://www.postgresql.org/) daemon and setup new database:

    initdb db/pg-data -E utf8;
    postgres -D db/pg-data
    rake db:setup

Start [streamer](streamer.rb) that will [LISTEN](http://www.postgresql.org/docs/9.4/static/sql-listen.html) to inserts and push KPIs to Databox.

    ./streamer.rb

Open another terminal / session and run following task that will import couple of prices.

    rake prices:import

For playing with data you can load [IRB](http://ruby-doc.org/stdlib-2.0.0/libdoc/irb/rdoc/IRB.html) session:

    irb -r./boot.rb
    Price.create date:DateTime.now, volume:100
    Price.import Price.all_from_ws

## Author
- [Oto Brglez](https://github.com/otobrglez)




