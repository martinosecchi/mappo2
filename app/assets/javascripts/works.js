//aggiunge input per un gruppo di places (stesso stato)
var addplaces= function(cont){
  $country=$('<input id=country-in-'+cont+' type="text" placeholder="Country"></input>');
  $textplaces=$('<textarea id=places-tx-'+cont+'  type="text" placeholder="Locations (separated by commas)"></textarea><br />');
  $('.places-text-fields').append($country);
  $('.places-text-fields').append($textplaces);
};

  //aggiunge input per un campo di extra
  var addextrafield= function(cont){
    $input=$('<input id=extra-in-'+cont+' type="text" placeholder="Field name"></input>');
    $textarea=$('<textarea id=extra-tx-'+cont+'  type="text" placeholder="Values"></textarea><br />');
    $('.extra-text-fields').append($input);
    $('.extra-text-fields').append($textarea);
  };

    //legge il valore preesistente di places
    var generate_places_data = function(places){
      dati=places.split(';');//crea un elemento in più-> l'ultimo è "" (se ci sono ; ma se no?)
      countries=[];
      places_in_country=[];
      for (i=0; i<dati.length-1; i++){
        pair=dati[i].split("),");
        places_in_country[i]=pair[0];
        countries[i]=pair[1];
        places_in_country[i]=places_in_country[i].replace('(','');
          countries[i]=countries[i].replace(";","")
        }
        retarray=[countries, places_in_country];
        return retarray;
      };

    //mostra nel form di update i campi di places come dei campi veri
    var prepare_places_for_update=function(){
      places=$('#places').val();

      dati=generate_places_data(places);
      countries=dati[0];
      places_in_country=dati[1];
      for (i=0; i<countries.length; i++){
        addplaces(i);
        $('#country-in-'+i).val(countries[i]);
        $('#places-tx-'+i).val(places_in_country[i]);
      }
      return countries.length; //voglio sapere quanti campi ci sono già così tengo aggiornato il contatore
    };

    // unisce i valori dei campi di extra, pronti per essere salvati in work.extra
    var process_extra=function(cont){
      if (cont > 0){
        var arrkeys=[];
        var arrvalues=[];
        var retkeys="[";
        var retvalues="[";
        for (var i=0; i < cont; i++){
          input=$('#extra-in-'+i).val();
          textarea=$('#extra-tx-'+i).val();
          if (input && input!="" && input!=" "){
            arrkeys.push(input);
            arrvalues.push(textarea);
          }
        }
      }
      if (arrkeys.length>0) {
        for (i = 0; i < arrkeys.length; i++) {
          retkeys=retkeys.concat("\""+arrkeys[i].toString()+"\"");
          retvalues=retvalues.concat("\""+arrvalues[i].toString()+"\"");
          if (i!=arrkeys.length-1) {
            retkeys=retkeys.concat(",");
            retvalues=retvalues.concat(",");
          };
        };
        retkeys=retkeys.concat("]");
        retvalues=retvalues.concat("]");
        //gli mando una stringa ma che ha la forma di un array JSON, così nel controller con un JSON.parse diventa un vero array
        $('#extra_keys').val(retkeys);
        $('#extra_values').val(retvalues);
      }
    };
    //unisce i valori dei campi di places, pronti per essere salvati in work.places
    var process_places = function(cont){
      var places="";
      var country="";
      var places_in_country="";
      for (i=0; i < cont; i++){
        country=$('#country-in-'+i).val();
        places_in_country=$('#places-tx-'+i).val();
        if ((country && country!="") || (places_in_country!="" && places_in_country) ){
          places=places.concat("("+places_in_country+"),"+country+";");
        }
        $('#places').val(places);
      }
    };
