# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# db/seeds.rb

# Clear out old data
ActionRecord.delete_all
Player.delete_all
GameRoom.delete_all

# Create a test room
room = GameRoom.create!(
  room_number: "TEST01",
  status: "lobby"
)

# Give it two players
room.players.create!(nickname: "Alice",  seat_number: 1, stack_amount: 1000, hole_cards: [])
room.players.create!(nickname: "Bob",    seat_number: 2, stack_amount: 1000, hole_cards: [])
