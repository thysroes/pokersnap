class PlayersController < ApplicationController
  def create
    room = GameRoom.find(params[:game_room_id])
    seat = room.players.count + 1
    player = room.players.create!(nickname: params[:nickname], seat_number: seat, stack_amount: 1000, hole_cards: [])
    # broadcast new player
    GameRoomChannel.broadcast_to(room, { type: 'player_joined', player: player })
    redirect_to game_room_path(room)
  end
end