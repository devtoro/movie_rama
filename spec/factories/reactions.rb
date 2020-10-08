FactoryBot.define do
  factory :reaction do
    trait :like do
      name { 'like' }
    end

    trait :dislike do
      name { 'dislike' }
    end
  end
end

# == Schema Information
#
# Table name: reactions
#
#  id         :bigint           not null, primary key
#  icon       :string
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
