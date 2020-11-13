require "rails_helper"

RSpec.describe Reaction, type: :model do
  context "Relationships" do
    it { should have_many(:movie_reactions) }
  end

  context "Validations" do
    it { should validate_presence_of(:name) }
  end
end
