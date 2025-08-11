# app/services/texas_holdem_engine.rb
class TexasHoldemEngine
  CARD_SUITS = %w[♠ ♥ ♦ ♣].freeze
  CARD_VALUES = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze

  def initialize(game_room)
    @game = game_room
    @deck = build_shuffled_deck
  end

  def start_hand
    reset_game_state
    deal_hole_cards
    deal_community_cards
    assign_blinds
    broadcast_state
    set_current_turn(after: :big_blind)
  end

  def process_action(action)
    # Basic placeholder – should update stack, pot, and turn
    player = action.player
    player.update!(stack_amount: player.stack_amount - action.amount)

    # Optionally: track pot or betting round here

    broadcast_state
  end

  private

  def build_shuffled_deck
    CARD_SUITS.product(CARD_VALUES).map { |suit, value| "#{value}#{suit}" }.shuffle
  end

  def reset_game_state
    @deck = build_shuffled_deck
    @game.players.update_all(hole_cards: [])
    @game.update!(community_cards: [], pot_amount: 0)
  end

  def deal_hole_cards
    @game.players.each do |player|
      player.update!(hole_cards: [@deck.pop, @deck.pop])
    end
  end

  def deal_community_cards
    flop = [@deck.pop, @deck.pop, @deck.pop]
    turn = @deck.pop
    river = @deck.pop
    @game.update!(community_cards: flop + [turn] + [river])
  end

  def assign_blinds
    small_blind = @game.players.order(:seat_number).first
    big_blind = @game.players.order(:seat_number).second

    small_blind.update!(stack_amount: small_blind.stack_amount - 10)
    big_blind.update!(stack_amount: big_blind.stack_amount - 20)

    @game.update!(pot_amount: 30)
  end

  def set_current_turn(after:)
    # optional: track whose turn it is
  end

  def broadcast_state
    GameRoomChannel.broadcast_to(@game, {
      type: "state_update",
      community_cards: @game.community_cards,
      pot: @game.pot_amount,
      players: @game.players.map do |p|
        {
          id: p.id,
          nickname: p.nickname,
          seat_number: p.seat_number,
          stack: p.stack_amount,
          hole_cards: p.hole_cards
        }
      end
    })
  end
end
