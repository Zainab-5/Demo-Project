# frozen_string_literal: true

class Feature < ApplicationRecord
  has_and_belongs_to_many :plans, dependent: :nullify
  has_many :usages

  validates :unit_price, :max_limit, presence: true

end
