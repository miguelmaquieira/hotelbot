class CreateFlats < ActiveRecord::Migration
  def change
    create_table :hotels do |t|
      t.string :city
      t.string :country
      t.string :address
      t.text :description
      t.integer :price
      t.text :rules

      t.timestamps null: false
    end
  end
end
