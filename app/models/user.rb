class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :wishlists
  has_many :hotel_styles

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [ :facebook, :linkedin ]

  def self.find_for_facebook_oauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]  # Fake password for validation
      user.name = auth.info.name
      user.picture = auth.info.image
      user.token = auth.credentials.token
      user.token_expiry = Time.at(auth.credentials.expires_at)
    end
  end

  def self.connect_to_linkedin(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    if user
      return user
    else
      registered_user = User.where(:email => auth.info.email).first
      if registered_user
        return registered_user
      else
        user = User.create(name:auth.info.first_name,
                            provider:auth.provider,
                            uid:auth.uid,
                            email:auth.info.email,
                            password:Devise.friendly_token[0,20],
                          )
      end
    end
  end

  AGE = [
    { id: 1, value: "65+" },
    { id: 2, value: "50-64" },
    { id: 3, value: "35-49" },
    { id: 4, value: "25-34" },
    { id: 5, value: "18-24" },
    { id: 6, value: "13-17" },
    { id: 7, value: "I prefer not to answer" }
  ]

  GENDER = [
    { id: 1, value: "Male" },
    { id: 2, value: "Female" },
    { id: 3, value: "Another gender identity" },
    { id: 4, value: "I prefer not to answer" }
  ]

  USUALLY_TRAVEL = [
    { id: 1, value: "Pleasure" },
    { id: 2, value: "Business" },
    { id: 3, value: "Business & Pleasure" }
  ]
end
