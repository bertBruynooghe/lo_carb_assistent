$(document).on('ready page:load', function() {
  function timeToSelect(id, date) {
    $(id + '_1i').val(date.getFullYear());
    $(id + '_2i').val(date.getMonth() + 1);
    $(id + '_3i').val(date.getDate());
    $(id + '_4i').val((date.getHours() + 100 + '').slice(1));
    $(id + '_5i').val((date.getMinutes() + 100 + '').slice(1));
  }

  function timeFromSelect(id) {
    var year = parseInt($(id + '_1i').val());
    var month = parseInt($(id + '_2i').val()) - 1;
    var date = parseInt($(id + '_3i').val());
    var hour = parseInt($(id + '_4i').val());
    var minute = parseInt($(id + '_5i').val());
    return new Date(year, month, date, hour, minute);
  }

  function timeSelectInLocalTimezone(id) {
    var offset_min = new Date().getTimezoneOffset();
    var date = timeFromSelect(id).valueOf();
    date = new Date(date - offset_min * 60000);
    timeToSelect(id, date);
    $(id + '_1i').parents('form').on('submit', function() {
      date = timeFromSelect(id).valueOf();
      date = new Date(date + offset_min * 60000);
      timeToSelect(id, date);
    });
  }

  $('[data-transform~=dateTimeLocalSelect]').each(function(_, el) {
    var id = $(el).find('select').attr('id').split('_').slice(0, -1).join('_');
    timeSelectInLocalTimezone('#' + id);
    $(el).find('.timeZone').remove();
  });
});
