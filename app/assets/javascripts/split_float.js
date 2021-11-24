$(function(){
  $('[data-transform=splitFloat] input').keypress(
    function(e){
      if (window.decimalSeparator.charCodeAt(0) == ((typeof e.which == "number") ? e.which : e.keyCode)){
        // console.log($(this));
        $(this).siblings('input').focus();
        return false;
      }
    }
  );
});
