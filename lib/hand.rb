require 'byebug'

class Hand
  # This is called a *factory method*; it's a *class method* that
  # takes the a `Deck` and creates and returns a `Hand`
  # object. This is in contrast to the `#initialize` method that
  # expects an `Array` of cards to hold.
  def self.deal_from(deck)
    Hand.new(deck.take(2))
  end

  attr_accessor :cards

  def initialize(cards)
    @cards = cards
  end

  def points
    points = 0
    ace_counter = 0
    @cards.each do |card|
      if card.value == :ace
        ace_counter += 1
        next
      end
      points += card.blackjack_value
    end
    if ace_counter > 0
      points += (points + 11 * ace_counter <= 21 ? 11 : ace_counter)
    end
    points
  end

  def busted?
    points > 21
  end

  def hit(deck)
    if busted?
      raise 'already busted'
      return false
    end
    @cards << deck.take(1).first
    true
  end

  def beats?(other_hand)
    return false if busted?
    return true if other_hand.busted?
    points > other_hand.points
  end

  def return_cards(deck)
    deck.return(@cards)
    @cards = []
  end

  def to_s
    @cards.join(",") + " (#{points})"
  end
end