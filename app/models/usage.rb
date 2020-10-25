# frozen_string_literal: true

class Usage < ApplicationRecord
  belongs_to :subscription
  belongs_to :feature
  validates :subscription_id, :feature_id, :units_used, presence: true
end
