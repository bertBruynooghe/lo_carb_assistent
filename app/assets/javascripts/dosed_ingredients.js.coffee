# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'ready page:load', ->
  findMatches = (q, cb) ->
    success = (ingredients) ->
      cb ({value: ingredient['name']} for ingredient in ingredients)
    $.ajax({
      url: "/ingredients?q[name_cont]=#{q}",
      data: {},
      success: success,
      dataType: 'json'
    });
    return

  $('input#dosed_ingredient_name').typeahead({
      minLength: 3,
      highlight: true,
      hint: true
    },
    {
      displayKey: 'value',
      source: findMatches
    });