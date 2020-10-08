
FactoryBot.define do
  factory :user do
    full_name { Faker::Name.full_name }
    email.unique { Faker::Internet.email }

    after_create do |user|
      create :movie, 5, user: user
    end
  end
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
