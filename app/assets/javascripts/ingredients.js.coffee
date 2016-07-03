# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'ready page:load', ->
  window.last_ingedients = []
  # does not seem to work on Windows phone; keyboard does not open on focus,
  # and select is lost when clicking on the field
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
      unless parseInt($('input#ingredient_carbs_integral').val()) ||
             parseInt($('input#ingredient_proteins_integral').val()) ||
             parseInt($('input#ingredient_fat_integral').val()) ||
             parseInt($('input#ingredient_calories_integral').val()) ||
             parseInt($('input#ingredient_carbs_fractional').val()) ||
             parseInt($('input#ingredient_proteins_fractional').val()) ||
             parseInt($('input#ingredient_fat_fractional').val()) ||
             parseInt($('input#ingredient_calories_fractional').val())
        $('input#ingredient_carbs_integral').val(stored_nutrient['carbs'].split('.')[0])
        $('input#ingredient_proteins_integral').val(stored_nutrient['proteins'].split('.')[0])
        $('input#ingredient_fat_integral').val(stored_nutrient['fat'].split('.')[0])
        $('input#ingredient_calories_integral').val(stored_nutrient['calories'].split('.')[0])
        $('input#ingredient_carbs_fractional').val(stored_nutrient['carbs'].split('.')[1])
        $('input#ingredient_proteins_fractional').val(stored_nutrient['proteins'].split('.')[1])
        $('input#ingredient_fat_fractional').val(stored_nutrient['fat'].split('.')[1])
        $('input#ingredient_calories_fractional').val(stored_nutrient['calories'].split('.')[1])
    false

  $('form input').on('keydown', (event) ->
    if (event.which == 13)
      currIndex = parseInt($(this).attr('tabindex'))
      $("*[tabindex='#{currIndex+1}']").focus().select()
  );
