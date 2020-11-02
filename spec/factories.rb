# frozen_string_literal: true

require 'factory_bot'
FactoryBot.define do
  factory :user do
    name  { 'zainab' }
    type  { 'Buyer' }
    email { Faker::Internet.safe_email }
    password { 'aaaaaa' }
  end

  factory :Admin do
    name  { 'zainab' }
    type  { 'Admin' }
    email { Faker::Internet.safe_email }
    password { 'aaaaaa' }
  end

  factory :plan do
    name  { 'plan1' }
    fee { 500 }
    user_id { 42 }
  end

  factory :subscription do
    billing_date { Date.today }
  end

  factory :usage do
    units_used { 600 }
  end

  factory :feature do
    name { 600 }
    code { 'abc' }
    unit_price { 6 }
    max_limit { 40 }
  end
end
