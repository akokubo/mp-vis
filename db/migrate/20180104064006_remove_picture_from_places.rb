class RemovePictureFromPlaces < ActiveRecord::Migration[5.1]
  def change
    remove_column :places, :picture
  end
end
