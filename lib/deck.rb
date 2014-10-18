require 'byebug'

# Represents a deck of playing cards.
class Deck
  # Returns an array of all 52 playing cards.
  def self.all_cards
    cards = []
    suits, values = Card.suits, Card.values
    suits.each { |suit| 13.times { |i| cards << Card.new(suit, values[i]) } }
    cards
  end

  def initialize(cards = Deck.all_cards)
    @deck = cards #an array of 52 Card objects
  end

  # Returns the number of cards in the deck.
  def count
    @deck.size
  end

  # Takes `n` cards from the top of the deck.
  def take(n)
    raise ArgumentError.new "not enough cards" if n > count
    @deck.shift(n)
  end

  # Returns an array of cards to the bottom of the deck.
  def return(cards)
    @deck.concat(cards)
  end
end

# d = Deck.new
# cards = [1, 2, 3]
# d.return(cards)