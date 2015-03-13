class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.references :hotel, index: true
      t.references :wishlist, index: true

      t.timestamps null: false
    end
    add_foreign_key :favorites, :hotels
    add_foreign_key :favorites, :wishlists
  end
end
