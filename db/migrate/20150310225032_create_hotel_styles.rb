class CreateHotelStyles < ActiveRecord::Migration
  def change
    create_table :hotel_styles do |t|
      t.references :user, index: true
      t.string :name

      t.timestamps null: false
    end
    add_foreign_key :hotel_styles, :users
  end
end
