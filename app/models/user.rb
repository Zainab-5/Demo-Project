# frozen_string_literal: true

class User < ApplicationRecord
  has_one_attached :image
  scope :admins, -> { where(type: 'Admin') }
  scope :buyers, -> { where(type: 'Buyer') }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  #use after_create callback and have check there if mage not exists then attach default image
  after_create do
    unless image.attached?
      image.attach(io: File.open(
        Rails.root.join('app', 'assets', 'images', 'dummy.jpg')), filename: 'dummy.jpg', content_type: 'image/jpg')
    end
  end
end
