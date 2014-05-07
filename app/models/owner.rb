class Owner < ActiveRecord::Base
    has_and_belongs_to_many :carts

    validates :email, :email_confirmation, :password, :password_confirmation, :carts, presence: true
    validates :email, :password, confirmation: true
    validates :email, uniqueness: true, email: true
end
