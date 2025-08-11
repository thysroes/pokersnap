class EnsureStatusDefaultsOnGameRooms < ActiveRecord::Migration[7.1]
  def up
    change_column_default :game_rooms, :status, 0
    execute "UPDATE game_rooms SET status = 0 WHERE status IS NULL"
    change_column_null :game_rooms, :status, false
    add_index :game_rooms, :status unless index_exists?(:game_rooms, :status)
  end

  def down
    change_column_null :game_rooms, :status, true
    change_column_default :game_rooms, :status, nil
    remove_index :game_rooms, :status if index_exists?(:game_rooms, :status)
  end
end