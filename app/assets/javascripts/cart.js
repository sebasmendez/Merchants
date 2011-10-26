jQuery(function(){

    $('a.add').live('ajax:success', function(xhr, data) {
     $(this).parent().html(data);
    });

});