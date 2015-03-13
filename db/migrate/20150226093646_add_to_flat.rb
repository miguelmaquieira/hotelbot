class AddToFlat < ActiveRecord::Migration
  def change
    add_column :hotels, :airbnb_id , :integer
  end
end
