class Owner < ActiveRecord::Base
    # Relations
    has_and_belongs_to_many :carts

    # Validations
    validates :email, :password, :password_encrypted, presence: true
    validates :password, confirmation: true
    validates :email, email: true, uniqueness: true

    # Devise
    devise :database_authenticatable, :registerable, :recoverable,
        :rememberable, :trackable, :validatable

    # Other
    attr_accessor :email, :password, :password_confirmation
end
