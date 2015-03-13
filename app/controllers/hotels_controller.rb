require 'open-uri'
require 'json'

class HotelsController < ApplicationController

  # GET /hotels
  # GET /hotels.json
  def index

    if params['predefined']
      @query_params = get_tags(params['predefined'])
      url_dropbox = get_url(params)
    elsif params['extra_tags']
      # url_dropbox = get_url(params)
      @query_params = JSON.parse(params['extra_tags'])
      url_dropbox = get_url_from_query_params(@query_params)
    end

    json_result = JSON.parse(open(url_dropbox).read)

    if json_result
      @hotels = json_result['result']
    end

    @markers = Gmaps4rails.build_markers(@hotels) do |hotel, marker|
      marker.lat hotel['latLng'][0]
      marker.lng hotel['latLng'][1]
    end

    @ambiances = Ambiance.all
    @facilities = Facility.all
    @prices = PriceCategory.all
  end

  # GET /hotel/1
  # GET /hotel/1.json
  def show
    @hotel = Hotel.find_by airbnb_id: params[:id]
  end

  private

    def get_url_from_query_params(query_params)
      p query_params
      url = "https://dl.dropboxusercontent.com/u/26873847/hotelsify/random-search.json"
      if (contains(query_params, 'Brussels') && contains(query_params, 'Shopping spot'))
        url = "https://dl.dropboxusercontent.com/u/26873847/hotelsify/user1-predefined-search-3.json"
      elsif contains(query_params, 'Shopping spot')
        url = "https://dl.dropboxusercontent.com/u/26873847/hotelsify/user1-predefined-search-2.json"
      end
    end

    def contains(query_params, value)
      query_params.each do |param|
       return true if param['value'] == value
      end
      return false
    end

    def get_url(params)
      user_case = params['predefined']
      url = "https://dl.dropboxusercontent.com/u/26873847/hotelsify/random-search.json"
      if user_case
        if user_case == 'user1'
          url = "https://dl.dropboxusercontent.com/u/26873847/hotelsify/user1-predefined-search-1.json"
        elsif user_case == 'style3'
          url = "https://dl.dropboxusercontent.com/u/26873847/hotelsify/user1-predefined-search-7.json"
        end
      end
    end

    def get_tags(predefined)
      tags =[]
      if predefined == 'user1'
        tags = [
          { id: "amb-1", value: "Stylish" },
          { id: "amb-7", value: "Deluxe" },
          { id: "amb-21", value: "Gourmet" }
        ]
      elsif predefined == 'style3'
        tags = [
          { id: "amb-16", value: "Kid-friendly" },
          { id: "amb-19", value: "Cosy" },
          { id: "amb-5", value: "Modern" },
          { id: "amb-20", value: "Bright" }
        ]
      elsif predefined == 'user2'
        tags = [
          { id: "amb-25", value: "design" },
          { id: "amb-26", value: "entertaining" },
          { id: "amb-27", value: "original" }
        ]
      elsif predefined == 'user3'
        tags = [
          { id: "amb-25", value: "cosy" },
          { id: "amb-26", value: "modern" },
          { id: "amb-27", value: "budget" }
        ]
      elsif predefined == 'location1'
        tags = [
          { id: "amb-25", value: "stylish" },
          { id: "amb-26", value: "nightlife" },
          { id: "fac-27", value: "pool" },
          { id: "loc-01", value: "barcelona" }
        ]
      elsif predefined == 'location2'
        tags = [
          { id: "amb-25", value: "business" },
          { id: "amb-26", value: "boutique" },
          { id: "fac-27", value: "gourmet" },
          { id: "loc-01", value: "London" }
        ]
      elsif predefined == 'location3'
        tags = [
          { id: "amb-25", value: "romantic" },
          { id: "amb-26", value: "deluxe" },
          { id: "fac-27", value: "panoramic" },
          { id: "loc-01", value: "Prague" }
        ]
      end
      tags
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def hotel_params
      params.require(:hotel).permit(:city, :country)
    end
end
