namespace :prices do
  desc "Load oil prices"
  task :import do
    size_of_imported = Price.import(Price.all_from_ws).ids.size
    puts "Successfuly imported #{size_of_imported} records."
  end
end
