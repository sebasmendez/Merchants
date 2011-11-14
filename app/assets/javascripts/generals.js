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
          if(key == 49 || key == 50 || key == 51 || key == 52 ||key == 53 || key == 54 || 
          key == 55 || key == 56 || key == 57 || key == 48){
            if (isNaN($('#newstock').val() )){ }
            else{
            sum += parseFloat( $('#newstock').val() );
            }
            if (isNaN($('#stock').val()) ){ }
            else {
            sum += parseFloat( $('#stock').val() )  ; 
            }
          $('#stock').attr('value', sum);
          }
        });
    
});