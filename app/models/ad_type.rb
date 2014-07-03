class AdType < ActiveRecord::Base
    # Relations
    has_many :ads

    # Validations
    validates :title, :description, :duration, :price, presence: true
    validates :price, :duration, numericality: true

    def as_json(options={})
        options[:only] ||= [:id, :title, :description, :duration, :price]
        super(options)
    end
end
