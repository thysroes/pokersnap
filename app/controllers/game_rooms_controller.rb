
class GameRoomsController < ApplicationController
  def new; end

  def create
    room = GameRoom.create!(room_number: SecureRandom.hex(3), status: 'lobby')
    redirect_to game_room_path(room)
  end

  def show
    @game_room = GameRoom.find(params[:id])
    @current_player = @game_room.players.find_by(id: params[:player_id])
  end

  def start_game
    room = GameRoom.find(params[:id])
    room.update!(status: 'in_progress')
    TexasHoldemEngine.new(room).start_hand
    head :ok
  end

  def next_hand
    room = GameRoom.find(params[:id])
    TexasHoldemEngine.new(room).start_hand
    head :ok
  end
end
