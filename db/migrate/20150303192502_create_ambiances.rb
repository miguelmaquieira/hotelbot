class CreateAmbiances < ActiveRecord::Migration
  def change
    create_table :ambiances do |t|
      t.string :text

      t.timestamps null: false
    end
  end
end
