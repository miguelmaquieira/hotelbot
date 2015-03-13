class AddHeadingToFlat < ActiveRecord::Migration
  def change
    add_column :hotels, :heading, :string
  end
end
