$(document).on('ready page:load', function(){
  function timeToSelect(id, date){
    $(id+'_1i').val(date.getFullYear());
    $(id+'_2i').val(date.getMonth() + 1);
    $(id+'_3i').val(date.getDate());
    $(id+'_4i').val((date.getHours()+100+'').slice(1));
    $(id+'_5i').val((date.getMinutes()+100+'').slice(1));
  }

  function timeFromSelect(id) {
    year = parseInt($(id+'_1i').val());
    month = parseInt($(id+'_2i').val()) - 1;
    date = parseInt($(id+'_3i').val());
    hour = parseInt($(id+'_4i').val());
    minute = parseInt($(id+'_5i').val());
    return new Date(year, month, date, hour, minute);
  }

  function timeSelectInLocalTimezone(id){
    offset_min = new Date().getTimezoneOffset();
    date = timeFromSelect(id).valueOf();
    date = new Date(date - offset_min * 60000);
    timeToSelect(id, date);
    $(id +'_1i').parents('form').on('submit', function(){
      date = timeFromSelect(id).valueOf();
      date = new Date(date + offset_min * 60000);
      timeToSelect(id, date);
    });
  }

  $('[data-transform=dateTimeLocalSelect]').each(function(_, el){
    id = $(el).find('select').attr('id').split('_').slice(0, -1).join('_');
    timeSelectInLocalTimezone('#'+id);
    $(el).find('.timeZone').remove();
  });
});
