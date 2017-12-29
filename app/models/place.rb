class Place < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  # uploaders/picture_uploader.rbと関連付け
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
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