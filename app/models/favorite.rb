class Favorite < ActiveRecord::Base
  belongs_to :hotel
  belongs_to :wishlist
end
