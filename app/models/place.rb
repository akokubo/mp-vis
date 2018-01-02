class Place < ApplicationRecord
  belongs_to :user
  default_scope -> { order(collected_at: :desc) }
  # uploaders/picture_uploader.rbと関連付け
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 140 }
  validates :mass, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :latitude, presence: true, numericality: { greater_than_or_equal_to: -90,  less_than_or_equal_to: 90 }
  validates :longitude, presence: true, numericality: { greater_than_or_equal_to: -180,  less_than_or_equal_to: 180 }
  validates :collected_at, presence: true

  validate  :picture_size

  private

    # Validates the size of an uploaded picture.
    def picture_size
      # 5MB上限を設定
      if picture.size > 5.megabytes
        errors.add(:picture, I18n.t("activerecord.errors.messages.should_be_less_than_5MB"))
      end
    end
end
