class AddCoordinatesToOpenCalls < ActiveRecord::Migration[5.2]
  def change
    add_column :open_calls, :latitude, :float
    add_column :open_calls, :longitude, :float
  end
end
