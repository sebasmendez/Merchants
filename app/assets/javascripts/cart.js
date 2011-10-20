$('a.add').live('ajax:success', function(xhr, data) {
 $(this).parent().html(data);
});

$('#product_quantity').click(function(xhr,data){
    $(this).replaceWith(function() {
        $(this).prompt('Quantity');} );
});

$('#add_button').click(function(){
   $(this).disabled = true
});