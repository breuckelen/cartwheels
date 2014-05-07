class User < ActiveRecord::Base
    has_one :search_history
    has_many :reviews
    has_and_belongs_to_many :favorites, :class_name => "Cart"
    has_and_belongs_to_many :cart_suggestions
    has_and_belongs_to_many :menu_suggestions

    validates :email, :email_confirmation, :password, :password_confirmation, :username, :zip_code, presence: true
    validates :email, :password, confirmation: true
    validates :email, :username, uniqueness: true
    validates :email, email: true
    validates :zip_code, numericality: true, format: {:with => /\A\d{5}\Z/}
end
