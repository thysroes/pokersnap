class AddCommunityCardsAndPotAmountToGameRooms < ActiveRecord::Migration[7.1]
  def change
    add_column :game_rooms, :community_cards, :jsonb, default: []
    add_column :game_rooms, :pot_amount, :integer, default: 0
  end
end
