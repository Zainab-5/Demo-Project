# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Subscription, type: :model do
  before(:all) do
    @subscription = build(:subscription)
    @admin = create(:Admin)
    @admin.plans << build(:plan)
    @subscription.plan = @admin.plans.first
    @subscription.plan.features << Feature.first
    @subscription.user = create(:user)
    @subscription.save!
  end

  it 'is valid with valid attributes' do
    expect(@subscription).to be_valid
  end

  it 'is not valid without a plan ID' do
    sub2 = build(:subscription, plan_id: nil, user_id: @admin.id)
    expect(sub2).to_not be_valid
  end

  it 'is not valid without a User ID' do
    sub3 = build(:subscription, plan_id: 3, user_id: nil)
    expect(sub3).to_not be_valid
  end

  it 'is not valid without a billing_date' do
    sub3 = build(:subscription, plan_id: @subscription.plan_id, user_id: @subscription.user_id, billing_date: nil)
    expect(sub3).to_not be_valid
  end

  it 'is not valid without a billing_date' do
    sub3 = build(:subscription, plan_id: @subscription.plan_id, user_id: @subscription.user_id, billing_date: nil)
    expect(sub3).to_not be_valid
  end

  describe '#save' do
    it "creates a transaction" do
      expect(@subscription.transactions.count).to eq(1)
    end
  end

  describe 'usage_used' do
    it "returns zero" do
      expect(@subscription.usage_used(@subscription.plan.features.first)).to eq(0)
    end

    it "returns non-zero" do
      feature =  @subscription.plan.features.first
      Usage.create!(units_used: 450, feature_id:feature.id, subscription_id: @subscription.id)
      expect(@subscription.usage_used(feature)).to eq(450)
    end
  end
end
