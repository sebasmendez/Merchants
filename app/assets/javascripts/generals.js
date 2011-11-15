jQuery(function(){
//    Autocalculate the finalprice
        $('#pricedist,#iva,#earn').keyup(function() {
          $('#price').attr('value',$('#pricedist').val() * 
            (parseFloat($('#iva').val())/100 + 1) * 
            (parseFloat($('#earn').val())/100 + 1) ); 
        });
//    Delete the "snowman" from search and disable the button
        $('form').submit(function() {
            $(this).find('input[type="submit"],\n\
                 input[name="utf8"]').attr('disabled', true
                );
}       );
//      Calcule the new stock
        $('#newstock').keyup(function(e) {
            var sum = 0;
            var key = e.which;
            var original = parseFloat($('#stock').val());
          if((key >= 48 && key <= 57) || (key >= 96 && key <= 105) ){
            if (isNaN($('#newstock').val() )){ }
            else{
                if ($('#newstock').val() == "" ){
                    sum = 0;
                }else {
                    sum += parseFloat( $('#newstock').val() ); }
            }
            if (isNaN($('#stock').val()) ){ }
            else {
            sum += parseFloat( $('#stock').val() )  ; 
            }
            if ($('#newstock').val() == ''){
                $('#stock').attr('value', 0);
            }
          $('#stock').attr('value', sum);
          }
        });
    
});