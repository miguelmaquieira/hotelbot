class CreateFacilities < ActiveRecord::Migration
  def change
    create_table :facilities do |t|
      t.string :text

      t.timestamps null: false
    end
  end
end
