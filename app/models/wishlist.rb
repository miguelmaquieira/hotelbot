class Wishlist < ActiveRecord::Base
  belongs_to :user
  has_many :favorites
end
