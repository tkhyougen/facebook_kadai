class Feed < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :user
  validates :message, presence: true, if: -> { image.blank? }
  validates :image, presence: true, if: -> { message.blank? }
end
