

function addElement(){
	alert("Hola mundo");
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