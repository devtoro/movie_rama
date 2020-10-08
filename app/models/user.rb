class User < ApplicationRecord
  # for bcrypt and authentication
  has_secure_password

  # Relationships
  has_many :movies
  has_many :movie_reactions
  has_many :reactions, through: :movie_reactions

  # Validations
  VALID_EMAIL_REGEX = /\A\w+([\'.-]?\w+)*@\w+([.-]?\w+)*(\.\w{2,6})+\z/.freeze
  validates :full_name, presence: true
  validates :email,
            presence: true,
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 8 }

  # Callbakcs
  before_save { self.email = email.downcase }
end

# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  avatar          :string
#  email           :string           not null
#  full_name       :string           not null
#  movies_count    :integer
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email)
#
