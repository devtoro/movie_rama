require 'rails_helper'

RSpec.describe Movie, type: :model do
  context 'Validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should have_db_column(:user_id) }
    it { should belong_to(:user) }
  end
end
