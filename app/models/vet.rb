class Vet < ApplicationRecord
    has_many :appointments, dependent: :destroy

    def normalize_email
        self.email = email.to_s.strip.downcase
    end
    before_validation :normalize_email
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :specialization, presence: true
    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

    scope :by_specialization, ->(spec) { where(specialization: spec) }
end
