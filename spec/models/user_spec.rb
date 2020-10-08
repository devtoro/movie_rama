require 'rails_helper'

RSpec.describe User, type: :model do
  let(:valid_user) { FactoryBot.build(:user) }
  let(:user_with_falsy_email) { FactoryBot.build(:user, :with_falsy_email) }

  context 'Validations' do
    it { should validate_presence_of(:full_name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password).is_at_least(8) }

    it 'Expexts user email to have proper format, otherwise User should be invalid' do
      user_with_falsy_email.valid?
      expect(user_with_falsy_email.errors[:email]).to include('is invalid')
    end

    it 'Expects User with full_name, email and password to be valid' do
      valid_user.valid?
      expect(valid_user.errors.messages.blank?).to eq(true)
    end
  end
end
