class User < ActiveRecord::Base
    # Relations
    has_one :search_history
    has_many :reviews
    has_many :clickthroughs
    has_many :photos, as: :author
    has_many :user_cart_relations
    has_many :uploads
    has_many :carts, :through => :user_cart_relations
    has_and_belongs_to_many :cart_ghosts
    has_and_belongs_to_many :menu_ghosts
    has_and_belongs_to_many :badges

    # Validations
    validates :email, :password, :zip_code, :roles_mask, presence: true
    validates :password, confirmation: true
    validates :email, email: true
    validates :zip_code, numericality: true, format: {:with => /\A\d{5}\Z/}

    # Devise
    devise :database_authenticatable, :registerable, :recoverable,
        :rememberable, :trackable, :validatable

    devise :omniauthable, :omniauth_providers => [:facebook, :google]

    # RoleModel
    include RoleModel

    roles_attribute :roles_mask
    roles :admin, :manager

    # Function to grant a user more priveleges
    def promote(level)
    end

    # Get carts based on others that this user has followed, reviewed, and
    # clicked on
    def suggested_carts
    end

    def self.find_for_facebook_oauth(auth)
    end

    def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
        data = access_token.info
        user = User.where(:email => data['email']).first

        unless user
            user = User.new(email: data['email'])
        end
        user
    end
end
