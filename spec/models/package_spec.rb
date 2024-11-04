require 'rails_helper'

RSpec.describe Package, type: :model do
  describe "associations" do
    it { should have_many(:orders).dependent(:destroy) }
  end

  describe "validations" do
    subject { build(:package) }

    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_presence_of(:price) }
    it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
  end
end
