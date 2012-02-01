jQuery(function($){
//    do "Paid" in mounth
        $('a.paid').live('ajax:success',function(xhr,data){
            $(this).parents('tr:first').replaceWith(data);
        });
        
        $('#impri').live('click', function(){
            javascript:window.print($('.printable'));
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
        
        // Calcule the total price in new order

            var count = $('.order_quantity').length;
            $('.order_quantity').live('change', function() {
            var i = 0;
            var total = 0;
            for (i=0; i< count; i++){
                var price = "#order_line_items_attributes_" + i + "_price";
                var quantity = "#order_line_items_attributes_" + i + "_quantity";
                price = parseFloat($(price).val());
                quantity = parseFloat($(quantity).val());
                parcial = parseFloat(price * quantity);
                total = parseFloat(total + parcial);
            }
             total = (Math.round(total*100) /100).toFixed(2);
             total = total.replace('.', ',');
             $('#order_total_price').text('$' + total);
        });
        
        
});