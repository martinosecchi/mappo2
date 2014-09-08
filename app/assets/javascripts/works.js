//aggiunge input per un gruppo di places (stesso stato)
  var addplaces= function(cont){
      $country=$('<input id=country-in-'+cont+' type="text" placeholder="country"></input>');
      $textplaces=$('<textarea id=places-tx-'+cont+'  type="text" placeholder="locations (separated by commas)"></textarea><br />');
      $('.places-text-fields').append($country);
      $('.places-text-fields').append($textplaces);
    };

  //aggiunge input per un campo di extra
  var addextrafield= function(cont){
      $input=$('<input id=extra-in-'+cont+' type="text" placeholder="field name"></input>');
      $textarea=$('<textarea id=extra-tx-'+cont+'  type="text" placeholder="values"></textarea><br />');
      $('.extra-text-fields').append($input);
      $('.extra-text-fields').append($textarea);
    };

    //legge il valore preesistente di extra
    var generate_extra_data = function(extra){
      dati=extra.split('-;-;-');//crea un elemento in più-> l'ultimo è ""
      keys=[];
      values=[];
      for (i=0; i<dati.length-1; i++){
        pair=dati[i].split('/:/:/');
        keys[i]=pair[0];
        values[i]=pair[1];
      }
      retarray=[keys, values];
      return retarray;
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

    //mostra nel form di update i campi di extra come dei campi veri
    var prepare_extra_for_update=function(){
      extra=$('#extra').val();
      //console.log("extra " + extra);
      dati=generate_extra_data(extra);
      keys=dati[0];   //console.log("keys " + keys);
      values=dati[1];   //console.log("values " + values);
      for (i=0; i<keys.length; i++){
        addextrafield(i);
        $('#extra-in-'+i).val(keys[i]);
        $('#extra-tx-'+i).val(values[i]);
      }
      return keys.length; //voglio sapere quanti campi ci sono già così tengo aggiornato il contatore
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
      var extra="";
      var input="";
      var textarea="";
      for (i=0; i < cont; i++){
        input=$('#extra-in-'+i).val();
        textarea=$('#extra-tx-'+i).val();
        if (input && input!=""){
          extra=extra.concat(input+"/:/:/"+textarea+"-;-;-");
        }
        //console.log(extra);
        $('#extra').val(extra);
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
        //console.log(places);
        $('#places').val(places);
    	}
    };
