

function addElement(){
	alert("Hola mundo");
}










$(document).ready(function(){

    $('.modal').modal();


    //list(); //List last 10

    $("#modal1").on('click', "#add", function() {
        addElement();
    });

    $('#type').material_select();



});