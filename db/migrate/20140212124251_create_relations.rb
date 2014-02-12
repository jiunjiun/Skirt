class CreateRelations < ActiveRecord::Migration
  def change
    create_table :relations do |t|
      t.string  :key
      t.integer :value
      t.timestamps
    end
  end
end
