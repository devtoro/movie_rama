require 'rails_helper'

RSpec.describe MovieReaction, type: :model do
  context 'Validations' do
    it { should have_db_column(:user_id) }
    it { should have_db_column(:reaction_id) }
    it { should have_db_column(:movie_id) }
    it { should belong_to(:user) }
    it { should belong_to(:reaction) }
    it { should belong_to(:movie) }
    it { should validate_uniqueness_of(:movie_id).scoped_to(:user_id) }
  end
end
