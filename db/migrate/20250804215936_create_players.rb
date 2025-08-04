class CreatePlayers < ActiveRecord::Migration[8.0]
  def change
    create_table :players do |t|
      t.string :nickname
      t.integer :seat_number
      t.integer :stack_amount
      t.jsonb :hole_cards
      t.references :game_room, null: false, foreign_key: true

      t.timestamps
    end
  end
end
