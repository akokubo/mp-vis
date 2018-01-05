class AddPhotosToPlaces < ActiveRecord::Migration[5.1]
  def change
    if Rails.env.production?
      add_column :places, :photos, :json
    elsif (Rails.env.development? or Rails.env.test?)
      add_column :places, :photos, :string
    end
  end
end
