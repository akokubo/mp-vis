class RenamePlaceContentDescription < ActiveRecord::Migration[5.1]
  def change
    rename_column :places, :content, :description
  end
end
