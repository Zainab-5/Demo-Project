# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Usage, type: :model do
  before(:all) do
    @usage = build(:usage)
    @feature = create(:feature)
    @plan = create(:plan)
    @plan.features << @feature
    @user = create(:user)
    @usage.subscription = create(:subscription, plan_id: @plan.id, user_id: @user.id)
    @usage.feature = @feature
  end

  it 'is valid with valid attributes' do
    expect(@usage).to be_valid
  end

  it 'is not valid without a feature ID' do
    sub2 = build(:usage, feature_id: nil, subscription_id: @usage.subscription_id)
    expect(sub2).to_not be_valid
  end

  it 'is not valid without a subscription ID' do
    sub2 = build(:usage, feature_id: @feature, subscription_id: nil)
    expect(sub2).to_not be_valid
  end

  it 'is not valid without units_used' do
    sub2 = build(:usage, feature_id: @feature, subscription_id: @usage.subscription_id, units_used: nil)
    expect(sub2).to_not be_valid
  end
end
