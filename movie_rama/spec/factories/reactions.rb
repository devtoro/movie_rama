FactoryBot.define do
  factory :reaction do
    name { "reaction" }
    color { "#5e5efc" }

    trait :like do
      name { "like" }
      color { "#5e5efc" }
    end

    trait :hate do
      name { "hate" }
      color { "#f74040" }
    end
  end
end

# == Schema Information
#
# Table name: reactions
#
#  id         :bigint           not null, primary key
#  color      :string
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
