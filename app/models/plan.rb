# frozen_string_literal: true

class Plan < ApplicationRecord
  belongs_to :admin, foreign_key: 'user_id'
  has_and_belongs_to_many :features, dependent: :nullify
  has_many :subscriptions
  has_many :buyers, through: :subscriptions, foreign_key: 'user_id'

  validates :name, :fee, :user_id, presence: true

  accepts_nested_attributes_for :features
end
