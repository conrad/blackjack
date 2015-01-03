class window.CardView extends Backbone.View
  className: 'card'

  template: _.template '<img src="img/cards/<%= rankName %>-<%= suitName %>.png">'
# "+@model.attributes.rankName.lower() + "-" + @model.attributes.suitName.lower() + ".png)"
  initialize: -> @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @model.attributes
    # @$el.css 'background-image', "url(../../img/cards/"+@model.attributes.rankName.lower() + "-" + @model.attributes.suitName.lower() + ".png)"
    @$el.addClass 'covered' unless @model.get 'revealed'

