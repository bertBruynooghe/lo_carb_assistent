$(document).on 'ready page:load', ->
  last_ingedients = []
  findMatches = (q, cb) ->
    success = (nutrients) ->
      last_ingedients = nutrients
      cb ({value: nutrient['name']} for nutrient in nutrients)
    $.ajax({ url: "/nutrients?q[name_cont]=#{q}", data: {}, success: success, dataType: 'json' });
    return

  dataSet = { displayKey: 'value', source: findMatches };
  $("input[data-typeahead='nutrient_name']")
    .typeahead({ minLength: 3, highlight: true, hint: true}, dataSet)
    .on 'blur', ->
      stored_nutrient = nutrient for nutrient in last_ingedients when nutrient['name'] == $(this).val()
      if stored_nutrient
        $('input[type="number"][id$="carbs_integral"]').val(stored_nutrient['carbs'].split('.')[0])
        $('input[type="number"][id$="proteins_integral"]').val(stored_nutrient['proteins'].split('.')[0])
        $('input[type="number"][id$="fat_integral"]').val(stored_nutrient['fat'].split('.')[0])
        $('input[type="number"][id$="calories_integral"]').val(stored_nutrient['calories'].split('.')[0])
        $('input[type="number"][id$="carbs_fractional"]').val(stored_nutrient['carbs'].split('.')[1])
        $('input[type="number"][id$="proteins_fractional"]').val(stored_nutrient['proteins'].split('.')[1])
        $('input[type="number"][id$="fat_fractional"]').val(stored_nutrient['fat'].split('.')[1])
        $('input[type="number"][id$="calories_fractional"]').val(stored_nutrient['calories'].split('.')[1])
      last_ingedients = []
      false

  $('form input').on('keydown', (event) ->
    if (event.which == 13)
      currIndex = parseInt($(this).attr('tabindex'))
      $("*[tabindex='#{currIndex+1}']").focus().select()
  );
