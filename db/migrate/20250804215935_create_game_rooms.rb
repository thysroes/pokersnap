class CreateGameRooms < ActiveRecord::Migration[8.0]
  def change
    create_table :game_rooms do |t|
      t.string :room_number
      t.string :status

      t.timestamps
    end
  end
end
