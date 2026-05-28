class User < ApplicationRecord
  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  enum :role, { owner: 0, vet: 1, admin: 2 }

  has_one :owner, dependent: :nullify
  has_one :vet, dependent: :nullify
end