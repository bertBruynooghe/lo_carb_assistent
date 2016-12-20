$(document).on('ready page:load', function() {
  var dataSet, findMatches, last_ingedients;
  last_ingedients = [];
  findMatches = function(q, cb) {
    var success;
    success = function(nutrients) {
      var nutrient;
      last_ingedients = nutrients;
      return cb((function() {
        var i, len, results;
        results = [];
        for (i = 0, len = nutrients.length; i < len; i++) {
          nutrient = nutrients[i];
          results.push({
            value: nutrient['name']
          });
        }
        return results;
      })());
    };
    $.ajax({
      url: "/nutrients?q[name_cont]=" + q,
      data: {},
      success: success,
      dataType: 'json'
    });
  };
  dataSet = {
    displayKey: 'value',
    source: findMatches
  };
  $("input[data-typeahead='nutrient_name']").typeahead({
    minLength: 3,
    highlight: true,
    hint: true
  }, dataSet).on('blur', function() {
    var i, len, nutrient, stored_nutrient;
    for (i = 0, len = last_ingedients.length; i < len; i++) {
      nutrient = last_ingedients[i];
      if (nutrient['name'] === $(this).val()) {
        stored_nutrient = nutrient;
      }
    }
    if (stored_nutrient) {
      $('input[type="number"][id$="carbs_integral"]').val(stored_nutrient['carbs'].split('.')[0]);
      $('input[type="number"][id$="proteins_integral"]').val(stored_nutrient['proteins'].split('.')[0]);
      $('input[type="number"][id$="fat_integral"]').val(stored_nutrient['fat'].split('.')[0]);
      $('input[type="number"][id$="calories_integral"]').val(stored_nutrient['calories'].split('.')[0]);
      $('input[type="number"][id$="carbs_fractional"]').val(stored_nutrient['carbs'].split('.')[1]);
      $('input[type="number"][id$="proteins_fractional"]').val(stored_nutrient['proteins'].split('.')[1]);
      $('input[type="number"][id$="fat_fractional"]').val(stored_nutrient['fat'].split('.')[1]);
      $('input[type="number"][id$="calories_fractional"]').val(stored_nutrient['calories'].split('.')[1]);
    }
    last_ingedients = [];
    return false;
  });
  return $('form input').on('keydown', function(event) {
    var currIndex;
    if (event.which === 13) {
      currIndex = parseInt($(this).attr('tabindex'));
      return $("*[tabindex='" + (currIndex + 1) + "']").focus().select();
    }
  });
});

// ---
// generated by coffee-script 1.9.2
