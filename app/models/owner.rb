class Owner < ActiveRecord::Base
    # Relations
    has_many :checkins, as: :user
    has_and_belongs_to_many :carts, :uniq => true

    # Validations
    validates :email, :password, presence: true
    validates :password, confirmation: true
    validates :email, email: true, uniqueness: true

    # Devise
    devise :database_authenticatable, :registerable, :recoverable,
        :rememberable, :trackable, :validatable

    def owners_carts
        []
    end

    before_save :ensure_authentication_token

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
        options[:include] ||= {
            :carts => { :only => [:id]}
        }
        super(options)
    end

    private :generate_authentication_token
end
