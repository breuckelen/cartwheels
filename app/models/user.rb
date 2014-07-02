class User < ActiveRecord::Base
    # Relations
    has_one :search_history
    has_one :profile_photo, class_name: "Photo", as: :target
    has_many :reviews
    has_many :clickthroughs
    has_many :photos
    has_many :user_cart_relations
    has_many :carts, :through => :user_cart_relations
    has_many :checkins, as: :user
    has_and_belongs_to_many :badges

    # Validations
    validates :name, :email, :password, :zip_code, :roles_mask, presence: true
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

    # Hooks
    before_save :ensure_authentication_token
    before_create :build_default_search_history

    def users_badges
        []
    end

    def build_default_search_history
        build_search_history
        true
    end

    # Function to grant a user more priveleges
    def promote(level)
    end

    # Get carts based on others that this user has followed, reviewed, and
    # clicked on
    def suggested_carts
    end

    def ensure_authentication_token
        if authentication_token.blank?
            self.authentication_token = generate_authentication_token
        end
    end

    def generate_authentication_token
        loop do
            token = Devise.friendly_token
            break token unless User.where(authentication_token: token).first
        end
    end

    def as_json(options={})
        options[:only] ||= [:id, :email, :name, :zip_code, :created_at, :updated_at]
        super(options)
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

    private :generate_authentication_token
end
