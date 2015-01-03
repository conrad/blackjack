class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    @add(@deck.pop())
    if @bustCheck()
      @bustOutput()

  stand: ->
    @standing = true
    # @dealerAct()

  bustCheck: ->
    @scores()[0] > 21 and @scores()[1] > 21

  bustOutput: ->
    if @isDealer
      alert("Dealer has busted. You win")
    else
      alert("You busted. You lose!")

  # look for dealer flag, get that score
  dealerAct: ->
    @models[0].flip()     # weird. bad practice to access models directly? collection instead? pulled 'models' from DOM
    # gameloop
    while (!@bustCheck())
      @hit()
      if @bustCheck()
        @bustOutput

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]
