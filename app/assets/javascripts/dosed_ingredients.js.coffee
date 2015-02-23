# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'ready page:load', ->
  $ ->
  $('input[type="number"]').keydown (event) ->
    if event.which == 188 or event.which == 190
      event.preventDefault()
      delimiter = if event.which == 188 then ',' else '.'
      currValue = @value
      if currValue == ''
        currValue = '0'
      newValue = currValue + delimiter + '1'
      @value = newValue
      if @value != newValue
        @value = currValue + (if delimiter == ',' then '.' else ',') + '1'
      @setSelectionRange currValue.length + 1, currValue.length + 2
    return
  return

  window.last_ingedients = []
  $('input#dosed_ingredient_quantity').focus().select()
  findMatches = (q, cb) ->
    success = (ingredients) ->
      window.last_ingedients = ingredients
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

  $('input#dosed_ingredient_name').on 'blur', ->
    stored_ingredient = ingredient for ingredient in window.last_ingedients when ingredient['name'] == $(this).val()
    if stored_ingredient
      unless $('input#dosed_ingredient_carbs').val() || $('input#dosed_ingredient_proteins').val() || $('input#dosed_ingredient_fat').val() || $('input#dosed_ingredient_calories').val()
        $('input#dosed_ingredient_carbs').val(stored_ingredient['carbs'])
        $('input#dosed_ingredient_proteins').val(stored_ingredient['proteins'])
        $('input#dosed_ingredient_fat').val(stored_ingredient['fat'])
        $('input#dosed_ingredient_calories').val(stored_ingredient['calories'])
    false

  $('form input').on('keydown', (event) ->
    if (event.which == 13)
      currIndex = parseInt($(this).attr('tabindex'))
      $("*[tabindex='#{currIndex+1}']").focus().select()
  );