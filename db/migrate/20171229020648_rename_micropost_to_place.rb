class RenameMicropostToPlace < ActiveRecord::Migration[5.1]
  def change
    rename_table :microposts, :places
  end
end
