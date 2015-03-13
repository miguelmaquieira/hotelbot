class HotelStyle < ActiveRecord::Base
  belongs_to :user

  acts_as_taggable_on :ambiances, :facilities
end
