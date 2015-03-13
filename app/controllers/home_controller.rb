require 'open-uri'

class HomeController < ApplicationController

  def welcome
   @ambiances = Ambiance.all
   @facilities = Facility.all
   @prices = PriceCategory.all

   @location_predefined = [
    { img: "welcome_city_05.jpg", name: "Barcelona", tags: "Stylish;Nightlife;Pool", predefined: 'location1' },
    { img: "welcome_city_02.png", name: "London", tags: "Business;Boutique;Gourmet", predefined: 'location2' },
    { img: "welcome_city_03.jpg", name: "Prague", tags: "Romantic;Deluxe;Panoramic", predefined: 'location3' }
   ]

   @style_predefined = [
    { img: "hotel_style_1.png", img_user: "user_4.png", name: "Paul", tags: "Stylish;Deluxe;Gourmet", predefined: 'user1' },
    { img: "hotel_style_9.png", img_user: "user_6.png", name: "Lili", tags: "Design;Entertaining;Original", predefined: 'user2' },
    { img: "hotel_style_5.png", img_user: "user_3.png", name: "Emma", tags: "Cosy;Modern;Budget", predefined: 'user3'}
   ]
 end

  def random
  end

end
