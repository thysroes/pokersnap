# app/models/game_room.rb
class GameRoom < ApplicationRecord
  has_many :players, dependent: :destroy
  has_many :action_records, dependent: :destroy

  enum :status, { lobby: 0, in_progress: 1, finished: 2 }

  validates :room_number, presence: true, uniqueness: true
end