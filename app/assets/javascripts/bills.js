jQuery(function(){
        $('#excel_with_month').live('click', function() {
          month = prompt('Ingrese el numero del mes');
          year = prompt('Ingrese el numero del año YYYY');
          url = window.location.pathname + ".csv?year=" + year + "&month=" + month;
          window.location = url;
        });
        
        
    
});

