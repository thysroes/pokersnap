class CreateActionRecords < ActiveRecord::Migration[8.0]
  def change
    create_table :action_records do |t|
      t.references :player, null: false, foreign_key: true
      t.references :game_room, null: false, foreign_key: true
      t.string :action_type
      t.integer :amount

      t.timestamps
    end
  end
end
