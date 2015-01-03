# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on('standing', @gameLoop, @)
    # @gameLoop()
    # console.log(@)

  gameLoop: ->
    @get('dealerHand').at(0).flip()
    while (!@get('dealerHand').bustCheck())
      if @get('dealerHand').optimalScore() < 17
        @get('dealerHand').hit()
      else
        if @compare() == 'tied' then alert('push')
        if @compare() == 'dealer' then alert('dealer wins')
        if @compare() == 'player' then alert('player wins')
        break

  compare: ->
    comparison = ''
    playerScore = @get('playerHand').optimalScore()
    dealerScore = @get('dealerHand').optimalScore()
    if playerScore == dealerScore then comparison = 'tied'
    if playerScore > dealerScore then comparison = 'player'
    if dealerScore > playerScore then comparison = 'dealer'
    comparison
