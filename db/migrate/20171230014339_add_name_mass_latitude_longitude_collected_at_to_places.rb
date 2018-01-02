class AddNameMassLatitudeLongitudeCollectedAtToPlaces < ActiveRecord::Migration[5.1]
  def change
    add_column :places, :name, :string
    add_column :places, :mass, :float
    add_column :places, :latitude, :float
    add_column :places, :longitude, :float
    add_column :places, :collected_at, :datetime
  end
end
