class TexasHoldemEngine
  def initialize(game_room)
    @game = game_room
    @deck = build_shuffled_deck
  end

  def start_hand
    reset_game_state
    deal_hole_cards
    assign_blinds
    broadcast_initial_state
    set_current_turn(after: :big_blind)
  end

  # ... methods: deal_hole_cards, assign_blinds, betting_round, flop, turn, river, showdown, reset_game_state

  private

  def build_shuffled_deck
    # return shuffled array of 52 card objects
  end
end
