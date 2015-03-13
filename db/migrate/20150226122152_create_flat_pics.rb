class CreateFlatPics < ActiveRecord::Migration
  def change
    create_table :hotel_pics do |t|
      t.string :image_url
      t.references :hotel, index: true
      t.timestamps null: false
    end
    add_foreign_key :hotel_pics, :hotels
  end
end
