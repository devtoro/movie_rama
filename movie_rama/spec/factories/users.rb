FactoryBot.define do
  factory :user do
    full_name { Faker::Name.first_name + " " + Faker::Name.last_name }
    email { Faker::Internet.unique.email }
    password { "movierama" }

    trait :without_name do
      full_name { nil }
    end

    trait :without_email do
      email { nil }
    end

    trait :with_falsy_email do
      email { "movierama@mail" }
    end

    trait :without_password do
      password { nil }
    end

    trait :with_short_password do
      password { "movie" }
    end

    trait :with_movies do
      after_create do |user|
        5.times { |i| create :movie, user: user }
      end
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
