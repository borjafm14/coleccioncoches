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
          "data": "{\n \"marca\":\""+data.marca+"\",\n  \"modelo\":\""+data.modelo+"\",\n  \"year\":\""+data.year+"\",\n  \"nacionalidad_coche\":\""+data.nacionalidad_coche+"\",\n  \"enlace_foto\":\""+data.enlace_foto+"\",\n  \"tipo\":\""+data.tipo+"\",\n  \"campeonato\":\""+data.campeonato+"\",\n  \"competicion\":\""+data.competicion+"\",\n  \"categoria\":\""+data.categoria+"\",\n  \"piloto\":\""+data.piloto+"\",\n  \"nacionalidad_piloto\":\""+data.nacionalidad_piloto+"\",\n  \"copiloto\":\""+data.nacionalidad_copiloto+"\",\n  \"precio\":\""+data.precio+"\",\n  \"fabricante\":\""+data.fabricante+"\",\n  \"descripcion\":\""+data.descripcion+"\"\n}"
      }).done(function (response) {

          //data = {AnalyticCODE : response.AnalyticCODE, AnalyticVALUE : response.AnalyticVALUE, Analytic_ID: response.Analytic_ID};

          //paint(data);

      });
}

function searchElements(){
	alert("Hola mundo");
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





$(document).ready(function(){

    $('.modal').modal();


    list(); //List last 10

    $("#modal1").on('click', "#add", function() {
        addElement();
    });

    $("#modal2").on('click', "#search", function() {
        searchElements();
    });

    $('#type').material_select();



});