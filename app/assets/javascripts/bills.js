jQuery(function(){
        $('#excel_with_month').live('click', function() {
          original_url = window.location.origin + window.location.pathname;
          month = prompt('Ingrese el numero del mes');
          year = prompt('Ingrese el numero del año YYYY');
          url = original_url + ".csv?year=" + year + "&month=" + month;
          window.location = url;
        });
        
        
    
});

