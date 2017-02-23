var rest = "https://coleccioncoches.azurewebsites.net/";

function paint(data){

}

function addElement(){
	data = {
        marca : $("#marca").val(),
        modelo : $('#modelo').val(),
        year : $('#year').val(),
        nacionalidad_coche : $('#nacionalidad_coche').val(),
        enlace_foto : $('#foto').val(),
        tipo : $('#tipo option:selected').val(),
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
          //"data": "{\n \"type\":\""+data.AnalyticCODE+"\",\n  \"value\":\""+data.AnalyticVALUE+"\"\n}"
          "data": data
      }).done(function (response) {

          //data = {AnalyticCODE : response.AnalyticCODE, AnalyticVALUE : response.AnalyticVALUE, Analytic_ID: response.Analytic_ID};

          //paint(data);

      });
}

function searchElements(){
	alert("Hola mundo");
}


function list(){
	
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