jQuery(function($){
//    do "Paid" in mounth
        $('a.paid').live('ajax:success',function(xhr,data){
            $(this).parents('tr:first').replaceWith(data);
        });
        
      
        // sum to amount
        var amount = parseFloat($('#amount').val());
        var original = parseFloat($('#amount').val());
        $('#to_amount').live('change', function() {
       
           if ($('#to_amount').val() == "" ){ 
               $('#amount').attr('value', original);
            }else {
                amount += parseFloat( $('#to_amount').val() )
                amount = (Math.round(amount*100) /100 ).toFixed(2)
                $('#amount').attr('value', amount); 
                amount = original;}
                
        });
        
        
});