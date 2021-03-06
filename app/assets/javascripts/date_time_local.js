$(function(){
  function inLast24Hours(date) {
    var value = new Date().valueOf() - date.valueOf();
    return 0 < value && value < (24 * 60 * 60 * 1000);
  }

  function inLastYear(date) {
    var value = new Date().valueOf() - date.valueOf();
    return 0 < value && value < (365 * 24 * 60 * 60 * 1000);
  }

  function inLastWeek(date) {
    var value = new Date().valueOf() - date.valueOf();
    return 0 < value && value < (7 * 24 * 60 * 60 * 1000);
  }
  
  $('[data-transform=dateTimeLocal]').each(function(_, el){
    var date = new Date($(el).text().trim());
    var text = date.getHours() + ':' + ((100 + date.getMinutes())+'').slice(1);
    if (!inLast24Hours(date)){ text += (' ' + window.abbrDayNames[date.getDay()]); }
    if (!inLastWeek(date)) { text += (', ' + date.getDate() + '/' + (date.getMonth()+1)); }
    if (!inLastYear(date)) { text += ('/' + date.getFullYear() ); }
    $(el).text(text);
  });
});
