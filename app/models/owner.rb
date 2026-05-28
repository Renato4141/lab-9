class Owner < ApplicationRecord
    has_many :pets, dependent: :destroy

    def normalize_email
        self.email = email.to_s.downcase.strip
    end

    before_validation :normalize_email

    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :phone, presence: true
    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
