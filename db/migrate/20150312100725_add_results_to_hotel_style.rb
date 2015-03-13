class AddResultsToHotelStyle < ActiveRecord::Migration
  def change
    add_column :hotel_styles, :url, :string
  end
end
