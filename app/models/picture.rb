class Picture < ApplicationRecord
  validates :image,  presence: true
  validates :comment, presence: true, length: { maximum: 255 }
  mount_uploader :image, ImageUploader
  has_many :favorites, dependent: :destroy
  belongs_to :user
end
