class User < ApplicationRecord
  has_one_attached :image
  scope :admins, -> { where(type: 'Admin') }
  scope :buyers, -> { where(type: 'Buyer') }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
