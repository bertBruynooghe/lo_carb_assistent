function timeFromSelect(id) {
  year = parseInt($(id+'_1i').val());
  month = parseInt($(id+'_2i').val()) - 1;
  date = parseInt($(id+'_3i').val());
  hour = parseInt($(id+'_4i').val());
  minute = parseInt($(id+'_5i').val());
  return new Date(year, month, date, hour, minute);
}

function timeToSelect(id, date){
  $(id+'_1i').val(date.getFullYear());
  $(id+'_2i').val(date.getMonth() + 1);
  $(id+'_3i').val(date.getDate());
  $(id+'_4i').val((date.getHours()+100+'').slice(1));
  $(id+'_5i').val((date.getMinutes()+100+'').slice(1));
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

$(function(){
  function inLast24Hours(date) {
    return (new Date().valueOf() - date.valueOf()) < (24 * 60 * 60 * 1000)
  }
  function inLastYear(date) {
    return (new Date().valueOf() - date.valueOf()) < (365 * 24 * 60 * 60 * 1000)
  }
  function inLastWeek(date) {
    return (new Date().valueOf() - date.valueOf()) < (7 * 24 * 60 * 60 * 1000);
  }
  $('[data-transform=localDatetime]').each(function(_, el){
    date = new Date($(el).text().trim());
    text = date.getHours() + ':' + ((100 + date.getMinutes())+'').slice(1);
    if (!inLast24Hours(date)){ text += (' ' + window.abbrDayNames[date.getDay()]); }
    if (!inLastWeek(date)) { text += (', ' + date.getDate() + '/' + (date.getMonth()+1)); }
    if (!inLastYear(date)) { text += ('/' + date.getFullYear() ); }
    $(el).text(text);
  });
});