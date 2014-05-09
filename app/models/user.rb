class User < ActiveRecord::Base
    # Associations
    has_one :search_history
    has_many :reviews
    has_many :clickthroughs
    has_many :photos, as: :author
    has_many :user_cart_relations
    has_many :carts, :through => :user_cart_relations
    has_and_belongs_to_many :cart_suggestions
    has_and_belongs_to_many :menu_suggestions

    # Encryption
    attr_encrypted :email, :key => SECRET_KEY, :attribute => 'email_encrypted'
    attr_encrypted :password, :key => SECRET_KEY, :attribute => 'password_encrypted'

    validates :email, :email_encrypted, :password, :password_encrypted, :username,
        :zip_code, presence: true
    validates :email, email: true
    validates :email_encrypted, uniqueness: true
    validates :zip_code, numericality: true, format: {:with => /\A\d{5}\Z/}
end
