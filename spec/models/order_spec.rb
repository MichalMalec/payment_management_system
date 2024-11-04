require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:user) { create(:user) }
  let(:package) { create(:package) }

  subject { described_class.new(order_date: Time.now, total_amount: 1000.0, user: user, package: package) }

  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:package) }
  end

  describe "validations" do
    it { should validate_presence_of(:order_date) }
    it { should validate_presence_of(:total_amount) }
    it { should validate_numericality_of(:total_amount).is_greater_than_or_equal_to(0) }
  end

  describe "enum status" do
    it "defines the statuses" do
      expect(Order.statuses.keys).to contain_exactly("pending", "completed", "failed")
    end
  end

  describe "creating an order" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without an order date" do
      subject.order_date = nil
      expect(subject).not_to be_valid
      expect(subject.errors[:order_date]).to include("can't be blank")
    end

    it "is not valid without a total amount" do
      subject.total_amount = nil
      expect(subject).not_to be_valid
      expect(subject.errors[:total_amount]).to include("can't be blank")
    end

    it "is not valid with a negative total amount" do
      subject.total_amount = -1
      expect(subject).not_to be_valid
      expect(subject.errors[:total_amount]).to include("must be greater than or equal to 0")
    end
  end
end
