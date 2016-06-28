# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'ready page:load', ->
  window.last_ingedients = []
  $('input#ingredient_quantity').focus().select()
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

  $('input#ingredient_name').typeahead({
      minLength: 3,
      highlight: true,
      hint: true
    },
    {
      displayKey: 'value',
      source: findMatches
    });

  $('input#ingredient_name').on 'blur', ->
    stored_nutrient = nutrient for nutrient in window.last_ingedients when nutrient['name'] == $(this).val()
    if stored_nutrient
      unless $('input#ingredient_carbs').val() || $('input#ingredient_proteins').val() || $('input#ingredient_fat').val() || $('input#ingredient_calories').val()
        $('input#ingredient_carbs').val(stored_nutrient['carbs'])
        $('input#ingredient_proteins').val(stored_nutrient['proteins'])
        $('input#ingredient_fat').val(stored_nutrient['fat'])
        $('input#ingredient_calories').val(stored_nutrient['calories'])
    false

  $('form input').on('keydown', (event) ->
    if (event.which == 13)
      currIndex = parseInt($(this).attr('tabindex'))
      $("*[tabindex='#{currIndex+1}']").focus().select()
  );
