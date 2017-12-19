class Bicycle < ApplicationRecord
  belongs_to :user
  has_many :positions, dependent: :destroy
  mount_uploader :image, ImagesUploader
end
