//var rest = "https://coleccioncoches.azurewebsites.net/";
var rest = "http://localhost:8080";

function paint(data){

}

function addElement(){
    //alert("Entro en add element");
	    data = {
        marca : $("#marca").val(),
        modelo : $('#modelo').val(),
        year : $('#year').val(),
        nacionalidad_coche : $('#nacionalidad_coche').val(),
        enlace_foto : $('#foto').val(),
        tipo : $('#type option:selected').val(),
        campeonato : $('#campeonato').val(),
        competicion : $('#competicion').val(),
        categoria : $('#categoria').val(),
        piloto : $('#piloto').val(),
        nacionalidad_piloto : $('#nacionalidad_piloto').val(),
        copiloto : $('#copiloto').val(),
        nacionalidad_copiloto : $('#nacionalidad_copiloto').val(),
        fabricante : $('#fabricante').val(),
        precio : $('#precio').val(),
        descripcion : $('#descripcion').val()
    };

      $.ajax({
          "crossDomain": true,
          "url": rest+"/add_element",
          "method": "POST",
          "headers": { "content-type": "application/json" },
          "data": "{\n \"marca\":\""+data.marca+"\",\n  \"modelo\":\""+data.modelo+"\",\n  \"year\":\""+data.year+"\",\n  \"nacionalidad_coche\":\""+data.nacionalidad_coche+"\",\n  \"enlace_foto\":\""+data.enlace_foto+"\",\n  \"tipo\":\""+data.tipo+"\",\n  \"campeonato\":\""+data.campeonato+"\",\n  \"competicion\":\""+data.competicion+"\",\n  \"categoria\":\""+data.categoria+"\",\n  \"piloto\":\""+data.piloto+"\",\n  \"nacionalidad_piloto\":\""+data.nacionalidad_piloto+"\",\n  \"copiloto\":\""+data.copiloto+"\",\n  \"nacionalidad_copiloto\":\""+data.nacionalidad_copiloto+"\",\n  \"precio\":\""+data.precio+"\",\n  \"fabricante\":\""+data.fabricante+"\",\n  \"descripcion\":\""+data.descripcion+"\"\n}"
      }).done(function (response) {

          //data = {AnalyticCODE : response.AnalyticCODE, AnalyticVALUE : response.AnalyticVALUE, Analytic_ID: response.Analytic_ID};

          //paint(data);

      });
}

function searchElements(){
  var dsde;
  if($('#siempre:checked').val()){
    dsde = "siempre";
  }
  else if($('#ultimoMes:checked').val()){
    dsde = "ultimoMes";
  }
  else{
    dsde = "hoy";
  }

  var type1;
  if($('#rally:checked').val()){
    type1 = 1;
  }
  else{
    type1 = 0;
  }

  var type2;
  if($('#circuito:checked').val()){
    type2 = 2;
  }
  else{
    type2 = 0;
  }

  var type3;
  if($('#calle:checked').val()){
    type3 = 3;
  }
  else{
    type3 = 0;
  }

	   data = {
        marca : $("#marca-search").val(),
        modelo : $('#modelo-search').val(),
        year : $('#year-search').val(),
        nacionalidad_coche : $('#nacionalidad_coche-search').val(),
        tipo1 : type1,
        tipo2 : type2,
        tipo3 : type3,
        campeonato : $('#campeonato-search').val(),
        competicion : $('#competicion-search').val(),
        categoria : $('#categoria-search').val(),
        piloto : $('#piloto-search').val(),
        nacionalidad_piloto : $('#nacionalidad_piloto-search').val(),
        copiloto : $('#copiloto-search').val(),
        nacionalidad_copiloto : $('#nacionalidad_copiloto-search').val(),
        fabricante : $('#fabricante-search').val(),
        precio : $('#precio-search').val(),
        desde : dsde
    };

      //alert("Tipo 1: " + data.tipo1);
      //alert("Tipo 2: "+ data.tipo2);
      //alert("Tipo 3: " + data.tipo3);
      //alert(data.desde);


      $.ajax({
          "crossDomain": true,
          "url": rest+"/list_elements",
          "method": "POST",
          "headers": { "content-type": "application/json" },
          "data": "{\n \"marca\":\""+data.marca+"\",\n  \"modelo\":\""+data.modelo+"\",\n  \"year\":\""+data.year+"\",\n  \"nacionalidad_coche\":\""+data.nacionalidad_coche+"\",\n  \"tipo1\":\""+data.tipo1+"\",\n  \"tipo2\":\""+data.tipo2+"\",\n  \"tipo3\":\""+data.tipo3+"\",\n  \"campeonato\":\""+data.campeonato+"\",\n  \"competicion\":\""+data.competicion+"\",\n  \"categoria\":\""+data.categoria+"\",\n  \"piloto\":\""+data.piloto+"\",\n  \"nacionalidad_piloto\":\""+data.nacionalidad_piloto+"\",\n  \"copiloto\":\""+data.copiloto+"\",\n  \"nacionalidad_copiloto\":\""+data.nacionalidad_copiloto+"\",\n  \"precio\":\""+data.precio+"\",\n  \"fabricante\":\""+data.fabricante+"\",\n  \"desde\":\""+data.desde+"\"\n}"
      }).done(function (response) {

          //data = {AnalyticCODE : response.AnalyticCODE, AnalyticVALUE : response.AnalyticVALUE, Analytic_ID: response.Analytic_ID};

          //paint(data);

      });
}


function list(){
    //alert("Entr en list");

    $.get(rest+"/list_last_elements", function(data, status){

      data = JSON.parse(data);
      size = Object.keys(data).length;

      $("#elements").empty();
      for(i=0; i<size; i++){
        //paint(data[i]);
      }

    });
	
}

function getinfo(){
  $.get(rest+"/get_info", function(data, status){

      //data = JSON.parse(data);
      //size = Object.keys(data).length;

      //$("#info").empty();
      //$('#info').append('<span>Coches totales: '+data.total+'</span><br><span>Coches de rally: '+data.rally+'</span><br><span>Cohes de circuito: '+data.circuito+'</span><br><span>Coches de calle: '+data.calle+'</span>');

  });
}





$(document).ready(function(){

    $('.modal').modal();

    getinfo(); //number of cars
    list(); //List last 10

    $("#modal1").on('click', "#add", function() {
        addElement();
    });

    $("#modal2").on('click', "#search", function() {
        searchElements();
    });

    $('#type').material_select();



});