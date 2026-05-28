class Pet < ApplicationRecord
  belongs_to :owner
  has_many :appointments, dependent: :destroy
  has_one_attached :photo

  def date_not_in_future
    if date_of_birth.present? && date_of_birth > Date.today
      errors.add(:date_of_birth, "can't be in the future")
    end
  end

  def capitalize_name
    self.name = name.to_s.capitalize
  end

  def normalize_species
    self.species = species.to_s.downcase.strip
  end

  before_validation :normalize_species
  before_save :capitalize_name

  validates :name, presence: true
  validates :owner, presence: true
  validates :species, presence: true, inclusion: { in: %w[dog cat rabbit bird reptile other] }
  validates :breed, presence: true
  validates :date_of_birth, presence: true
  validate :date_not_in_future
  validates :weight, presence: true, numericality: { greater_than: 0 }
  validate :photo_validation

  scope :by_species, ->(species) { where(species: species.to_s.downcase) }

  def photo_validation
    return unless photo.attached?

    allowed_types = ["image/jpeg", "image/png", "image/webp","image/avif"]

    unless allowed_types.include?(photo.content_type)
      errors.add(:photo, "must be a JPEG, PNG, WEBP, or AVIF type")
    end

    if photo.attached? && photo.blob.present? && photo.blob.byte_size > 5.megabytes
      errors.add(:photo, "Maximum size is 5MB.")
    end
  end
end