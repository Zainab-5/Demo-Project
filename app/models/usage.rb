# frozen_string_literal: true

class Usage < ApplicationRecord
  belongs_to :subscription
  belongs_to :feature
  attr_accessor :is_billed

  validates :subscription_id, :feature_id, :units_used, presence: true
end
