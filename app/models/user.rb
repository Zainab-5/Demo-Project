# frozen_string_literal: true

class User < ApplicationRecord
  has_one_attached :image
  has_many :subscriptions
  scope :admins, -> { where(type: 'Admin') }
  scope :buyers, -> { where(type: 'Buyer') }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validate :upload_is_image, if: -> { image.attached? }

  private

  def upload_is_image
    errors.add(:file, 'Not an image.') unless image && image.content_type =~ (%r{^image/(jpeg|pjpeg|gif|png|bmp)$})
  end
end
