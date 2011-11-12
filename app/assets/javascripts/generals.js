jQuery(function(){
    
    $(document).ready(function() {
        $('#product_pricedist','#product_iva','#product_earn').change(function(e) {
        var $row = $(this).val()
        var pricedist = $('#product_pricedist').val();
        var iva = "1." + $('#product_iva').val();
        var earn = "1." + $('#product_earn]').val();
        total = parseFloat( pricedist * iva * earn);
        
       $('#product_price').repaceWith(total);

       
    });
});
    
    
});