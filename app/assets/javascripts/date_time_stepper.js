$(document).on('ready page:load', function() {
  //TODO: this does not yet take account of actual #days of the month

  function stepUp($select) {
    var $newSelection = $select.find('option:selected').next();
    if (0 == $newSelection.length) {
      $newSelection = $select.find('option');
      stepUp($select.$nextSelect);
    }
    $select.val($newSelection.val());
  }

  function stepDown($select) {
    var $newSelection = $select.find('option:selected').prev();
    if (0 == $newSelection.length) {
      $newSelection = $select.find('option').last();
      stepDown($select.$nextSelect);
    }
    $select.val($newSelection.val());
  }

  function createUpButton($select){
    return $('<button type="button"/>').text("+").click(function() {
      stepUp($select);
    });
  }

  function createDownButton($select){
    return $('<button type="button"/>').text("-").click(function() {
      stepDown($select);
    });
  }

  function makeSelectSteppable($select, $nextSelect){
    $select['$nextSelect'] = $nextSelect;
    var $up = createUpButton($select);
    var $down = createDownButton($select);
    return $select.after($up).after($down);
  }

  function makeSteppable(el){
    var $nextSelect = undefined;
    $.each(['year', 'month', 'day', 'hour', 'minute'], function(_, unit) {
      $nextSelect = makeSelectSteppable($(el).find('select.' + unit), $nextSelect);
    });
  }

  $('[data-transform~=steppable]').each(function(_, el) {
    makeSteppable(el);
  });
});
