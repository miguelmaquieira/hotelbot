class ChangeAirbnbFormatInFlats < ActiveRecord::Migration
   def up
    change_column :hotels, :airbnb_id, :string
  end

  def down
    change_column :hotels, :airbnb_id, :integer
  end
end
