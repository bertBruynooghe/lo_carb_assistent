# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'ready page:load', ->
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

  window.last_ingedients = []
  $('input#meal_component_quantity').focus().select()
  findMatches = (q, cb) ->
    success = (nutrients) ->
      window.last_ingedients = nutrients
      cb ({value: nutrient['name']} for nutrient in nutrients)
    $.ajax({
      url: "/nutrients?q[name_cont]=#{q}",
      data: {},
      success: success,
      dataType: 'json'
    });
    return

  $('input#meal_component_name').typeahead({
      minLength: 3,
      highlight: true,
      hint: true
    },
    {
      displayKey: 'value',
      source: findMatches
    });

  $('input#meal_component_name').on 'blur', ->
    stored_nutrient = nutrient for nutrient in window.last_ingedients when nutrient['name'] == $(this).val()
    if stored_nutrient
      unless $('input#meal_component_carbs').val() || $('input#meal_component_proteins').val() || $('input#meal_component_fat').val() || $('input#meal_component_calories').val()
        $('input#meal_component_carbs').val(stored_nutrient['carbs'])
        $('input#meal_component_proteins').val(stored_nutrient['proteins'])
        $('input#meal_component_fat').val(stored_nutrient['fat'])
        $('input#meal_component_calories').val(stored_nutrient['calories'])
    false

  $('form input').on('keydown', (event) ->
    if (event.which == 13)
      currIndex = parseInt($(this).attr('tabindex'))
      $("*[tabindex='#{currIndex+1}']").focus().select()
  );