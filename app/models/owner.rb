class Owner < ActiveRecord::Base
    # Associations
    has_and_belongs_to_many :carts

    # Encryption
    attr_encrypted :email, :key => SECRET_KEY, :attribute => 'email_encrypted'
    attr_encrypted :password, :key => SECRET_KEY, :attribute => 'password_encrypted'

    # Validations
    validates :email, :email_encrypted, :password, :password_encrypted,
        presence: true
    validates :email, email: true
    validates :email_encrypted, uniqueness: true
end
