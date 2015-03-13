require 'open-uri'
require 'json'

class ProfileController < ApplicationController
  before_action :authenticate_user!

  def show_styles
    @ambiances = Ambiance.all
    @facilities = Facility.all
    @prices = PriceCategory.all

    @hotel_styles = current_user.hotel_styles
    if @hotel_styles
      @recomendations = get_styles_recomendations(@hotel_styles)
    end
    render "show"
  end

  def show_whishlists
    current_user

    render "show"
  end

  def show_deals
    current_user

    render "show"
  end

  def show_groups
    current_user

    render "show"
  end

  def show_settings
    current_user

    render "show"
  end

  def create

  end

  def hotel_styles_new
    @registration = true
    @ambiances = Ambiance.all
    @step = 2
    render layout: "devise"
  end

  def hotel_styles_create
    if params[:ambiances]
      add_default_hotel_style(params[:ambiances])
    end
    @registration = true
    @step = 3
    @ages = User::AGE
    @gender = User::GENDER
    @usually_travel = User::USUALLY_TRAVEL
    render layout: "devise"
  end

  def basic_info
    if params[:basic_info]
      current_user.age = params[:basic_info][:age]
      current_user.gender = params[:basic_info][:gender]
      current_user.traveling = params[:basic_info][:usually]
      current_user.save
    end
    redirect_to home_welcome_path
  end

  def add_to_wishlist

  end

  def add_new_hotel_style
    if params['extra_tags']
      query_params = JSON.parse(params['extra_tags'])
      add_hotel_style(query_params)
    end
    redirect_to profile_show_styles_path
  end

  private

    def get_styles_recomendations(hotel_styles)
      recomendations = {}
      base_url = 'https://dl.dropboxusercontent.com/u/26873847/hotelsify/'
      hotel_styles.each do |hotel_style|
        url = base_url + 'user_id_1_style_' + hotel_style.url + '.json'
        p url
        p 'sdfsdfsdfsdfsfd'
        json_result = JSON.parse(open(url).read)
        recomendations[hotel_style.name] = json_result
      end
      recomendations
    end

    def add_default_hotel_style(ambiances)
      hotel_style = HotelStyle.create(
        name: 'My Style 1',
        user_id: current_user.id,
        url: 'style1'
        )
      ambiances.keys.each do |ambiance|
        hotel_style.ambiance_list.add(ambiance, parse: true)
      end
      hotel_style.save
    end

    def add_hotel_style(extra_params)
      styles_size = current_user.hotel_styles.size + 1
      hotel_style = HotelStyle.create(
        name: 'My Style ' + styles_size.to_s,
        user_id: current_user.id,
        url: 'style' + styles_size.to_s
        )
      extra_params.each do |tag|
        hotel_style.ambiance_list.add(tag['value'], parse: true)
      end
      hotel_style.save
    end

end