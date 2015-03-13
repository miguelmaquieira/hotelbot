class Users::RegistrationsController < Devise::RegistrationsController

  def new
    @registration = true
    super
    #render layout: 'devise', registration: true)
  end

  protected
    def after_sign_up_path_for(resource)
      profile_hotel_styles_new_path
    end
end
