/* Transforms all Rails datetime_selects which contain 'steppable' in their data-transform attribute
   into a set of 'steppable' selects.
   This means that each select has an up/down button that increments/decrements the value without opening the dropdown.
   This is essentially done to improve mobile UX.
   In a next iteration, holding down the button will make the select continuously increment/decrement. */
$(document).on('ready page:load', function() {
  function hasInvalidSelection($select) {
    if ($select.filter('.day').length == 0) return false;
    var year = $select.$nextSelect.$nextSelect.val();
    var month = $select.$nextSelect.val() - 1;
    var day = $select.val()
    return day != new Date(year, month, day).getDate();
  }

  function stepUp($select) {
    $select.val($select.find(':selected').next().val());
    if (null === $select.val()) {
      $select.val($select.find('option').first().val());
      stepUp($select.$nextSelect);
    }
    if (hasInvalidSelection($select)) stepUp($select);
  }

  function stepDown($select) {
    $select.val($select.find(':selected').prev().val());
    if (null === $select.val()) {
      $select.val($select.find('option').last().val());
      stepDown($select.$nextSelect);
    }
    if (hasInvalidSelection($select)) stepDown($select);
  }

  function createUpButton($select) {
    return $('<button type="button"/>').text("+").click(function() {
      stepUp($select);
    });
  }

  function createDownButton($select) {
    return $('<button type="button"/>').text("-").click(function() {
      stepDown($select);
    });
  }

  function makeSelectSteppable($select, $nextSelect) {
    $select['$nextSelect'] = $nextSelect;
    var $up = createUpButton($select);
    var $down = createDownButton($select);
    return $select.after($up).after($down);
  }

  function makeSteppable(dateTimePicker) {
    var $nextSelect = undefined;
    $.each(['year', 'month', 'day', 'hour', 'minute'], function(_, unit) {
      var $select = $(dateTimePicker).find('select.' + unit);
      $nextSelect = makeSelectSteppable($select, $nextSelect);
    });
  }

  $('[data-transform~=steppable]').each(function(_, dateTimePicker) {
    makeSteppable(dateTimePicker);
  });
});
