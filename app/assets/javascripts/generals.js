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

    
});