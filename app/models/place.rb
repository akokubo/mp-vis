class Place < ApplicationRecord
  belongs_to :user
  default_scope -> { order(collected_at: :desc) }
  # uploaders/photos_uploader.rbと関連付け
  mount_uploaders :photos, PhotoUploader
  serialize :photos, JSON if (Rails.env.development? or Rails.env.test?)
  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 140 }
  validates :mass, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :latitude, presence: true, numericality: { greater_than_or_equal_to: -90,  less_than_or_equal_to: 90 }
  validates :longitude, presence: true, numericality: { greater_than_or_equal_to: -180,  less_than_or_equal_to: 180 }
  validates :collected_at, presence: true

  validate  :photo_size

  private

    # Validates the size of an uploaded picture.
    def photo_size
      photos.each do |photo|
        if photo.size > 5.megabytes
          errors.add(:photos, I18n.t("activerecord.errors.messages.should_be_less_than_5MB"))
        end
      end
    end
end
