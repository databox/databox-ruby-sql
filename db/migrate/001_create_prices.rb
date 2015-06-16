class CreatePrices < ActiveRecord::Migration

  create_table :prices do |t|
    t.date :date, null: false
    t.float :volume, null: false
  end
end
