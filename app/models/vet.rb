class Vet < ApplicationRecord
  belongs_to :user, optional: true
  has_many :appointments, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name,  presence: true
  validates :phone,      presence: true
  validates :email,      presence: true, uniqueness: true,
                         format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :specialization, presence: true

  scope :by_specialization, ->(s) { where(specialization: s) }
end