class Hotel < ActiveRecord::Base
  has_many :hotel_pics, :dependent => :destroy
  belongs_to :user
  acts_as_taggable_on :ambiances , :facilities, :cities, :babas
  has_many :favorites

  def self.store_from_hash(json_result)
    if json_result
      json_result['result'].each do |params|
        hash_of_params = {}
        hash_of_params[:airbnb_id] = params['id']
        hash_of_params[:description] = params['attr']['description']
        hash_of_params[:city] = params['location']['city']
        hash_of_params[:city] = params['location']['country']
        hash_of_params[:price] = params['price']['nightly']
        hash_of_params[:longitude] = params["latLng"][1]
        hash_of_params[:latitude] = params["latLng"][0]
        hash_of_params[:heading] = params["attr"]["heading"]
        unless Hotel.find_by airbnb_id: hash_of_params[:airbnb_id] then
          a_hotel = Hotel.create(hash_of_params)
          params['photos'].each do |photo|
           a_hotel.hotel_pics.create(image_url: photo['large'])
          end
        end
      end
    end
  end
end
