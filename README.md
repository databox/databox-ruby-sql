# SQL → Databox with Databox Ruby Gem

Answer to the question: How to move data from [PostgreSQL](http://www.postgresql.org/) to Databox with [Databox Ruby Gem / SDK](https://github.com/databox/databox-ruby)?

## Example

Create new database, start [PostgreSQL](http://www.postgresql.org/) daemon and setup database
```
initdb db/pg-data -E utf8;
postgres -D db/pg-data
rake db:setup
```

## Author
- [Oto Brglez](https://github.com/otobrglez)




