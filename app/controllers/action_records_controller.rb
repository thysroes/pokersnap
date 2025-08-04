    class ActionRecordsController < ApplicationController
  def create
    room = GameRoom.find(params[:game_room_id])
    player = room.players.find(params[:player_id])
    action = room.action_records.create!(
      player: player,
      action_type: params[:action_type],
      amount: params[:amount]
    )
    # Update engine state, stacks, pot, turn...
    TexasHoldemEngine.new(room).process_action(action)
    head :ok
  end
end
