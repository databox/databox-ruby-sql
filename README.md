# SQL → Databox with Databox Ruby Gem

Answer to the question: How to move data from [PostgreSQL](http://www.postgresql.org/) to Databox with [Databox Ruby Gem / SDK](https://github.com/databox/databox-ruby)?

## Example

Create new database, start [PostgreSQL](http://www.postgresql.org/) daemon and setup database

    initdb db/pg-data -E utf8;
    postgres -D db/pg-data
    rake db:setup

Start [streamer](streamer.rb) that will [LISTEN](http://www.postgresql.org/docs/9.4/static/sql-listen.html) to inserts to `prices` table and transport KPIs to Databox.

    ./streamer.rb


For playing with data you can load [IRB](http://ruby-doc.org/stdlib-2.0.0/libdoc/irb/rdoc/IRB.html) session:

    irb -r./boot.rb

## Author
- [Oto Brglez](https://github.com/otobrglez)




