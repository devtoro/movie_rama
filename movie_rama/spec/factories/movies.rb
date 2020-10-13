FactoryBot.define do
  factory :movie do
    title { Faker::Book.unique.title }
    description { Faker::Lorem.paragraph(sentence_count: 10) }
    association :user, factory: :user
  end
end

# == Schema Information
#
# Table name: movies
#
#  id          :bigint           not null, primary key
#  description :text             not null
#  title       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_movies_on_title    (title)
#  index_movies_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_2c7f519372  (user_id => users.id)
#
