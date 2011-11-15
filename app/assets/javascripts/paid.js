jQuery(function($){
//    do "Paid" in mounth
        $('a.paid').live('ajax:success',function(xhr,data){
            $(this).parents('tr:first').replaceWith(data);
        });
        
        // show the "to_amount field"
        if(parseFloat( $('#amount').val() ) != 0.0) {
                $('#to_amount').attr('hidden', false);
                $('#notice_to_amount').attr('hidden', false); }
        
        // sum to amount
        $('#to_amount').keyup(function(e) {
            var sum = 0;
            var key = e.which;
            var original = parseFloat($('#amount').val());
          if((key >= 48 && key <= 57) || (key >= 96 && key <= 105) ){
            if (isNaN($('#to_amount').val() )){ }
            else{
                if ($('#to_amount').val() == "" ){
                    sum = 0;
                }else {
                    sum += parseFloat( $('#to_amount').val() ); }
            }
            if (isNaN($('#amount').val()) ){ }
            else {
            sum += parseFloat( $('#amount').val() )  ; 
            }
            if ($('#to_amount').val() == ''){
                $('#amount').attr('value', 0);
            }
          $('#amount').attr('value', sum);
          }
        });
        
        
});