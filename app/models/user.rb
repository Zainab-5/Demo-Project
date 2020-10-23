class User < ApplicationRecord
  has_one_attached :image
  scope :admins, -> { where(type: 'Admin') }
  scope :buyers, -> { where(type: 'Buyer') }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_create do
    self.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'dummy.jpg')), filename: 'dummy.jpg', content_type: 'image/jpg')
  end
end
