jQuery(function(){

//    $('a.add').live('ajax:success', function(xhr, data) {
//     $(this).parent().html(data);
//    });
//
//        $('.add_button').live('ajax:success',function(xhr,data){
//            $(this).parents('tr:first').html("<%=j render 'store/product' %>");
//        });
//
//    $('.add_button').live('click',function() {
//    $(this).html("<%= render partial: 'store/product' %>");
//    });

//        $('.add_button').click(function(){
//        $(this).attr('disabled', true);
//        });
       $('#order_auto_client').autocomplete({
           source: 'clients/autocompletar.js'
       });


});