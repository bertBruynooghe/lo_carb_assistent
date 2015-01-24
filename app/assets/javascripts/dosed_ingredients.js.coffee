# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'ready page:load', ->
  findMatches = (q, cb) ->
    cb [{value: 'test'}, {value: 'test2'}]
    return

#  $('input#dosed_ingredient_name').typeahead({
#      minLength: 3,
#      highlight: true,
#      hint: true
#    },
#    {
#      displayKey: 'value',
#      source: findMatches
#    });