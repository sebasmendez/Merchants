jQuery(function($){
    
        $('a.paid').live('ajax:success',function(xhr,data){
            $(this).parents('tr:first').replaceWith(data);
        });
        
        
});