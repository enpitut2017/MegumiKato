class Bicycle < ApplicationRecord
  belongs_to :user
  mount_uploader :image, ImagesUploader
end
