class User < ActiveRecord::Base
    # Relations
    has_one :search_history
    has_many :reviews
    has_many :clickthroughs
    has_many :photos, as: :author
    has_many :user_cart_relations
    has_many :carts, :through => :user_cart_relations
    has_and_belongs_to_many :cart_ghosts
    has_and_belongs_to_many :menu_ghosts

    # Validations
    validates :email, :password, :zip_code, presence: true
    validates :password, confirmation: true
    validates :email, email: true, uniqueness: true
    validates :zip_code, numericality: true, format: {:with => /\A\d{5}\Z/}

    # Devise
    devise :database_authenticatable, :registerable, :recoverable,
        :rememberable, :trackable, :validatable

    # Other
    attr_accessor :email, :password, :password_confirmation
end
