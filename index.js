
var express = require('express');
var app = express();
var bodyParser = require('body-parser');
var server = require('http').Server(app);
var sql = require('mssql');

var vars = {
   	//domain:'https://coleccioncoches.azurewebsites.net/',
   	server_port: 8080,
  	sql: null,
  	sql_config : {
    	user: 'borjafm14',
    	password: 'Iverson3$',
    	server: 'coches.database.windows.net',
    	database: 'COCHES',
    	options: { encrypt: true /* Use this if you're on Windows Azure */ }
  	}

}

sql.connect(vars.sql_config).catch(function(err) {
  console.log('SQL-> Error al conectarse a la base de datos (línea 22');
});
vars.sql = sql;

server.listen(vars.server_port);
app.use(bodyParser.json());
app.use(function(req, res, next) { //Allow cors (cross domain...)
  res.header("Access-Control-Allow-Origin", "*");
  res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
  next();
});


app.use(express.static('../coleccioncoches')); //Static server of the interface




app.get('/list_last_elements', function (req, res) {
    //console.log("Entro en list_last_elements");
   var request = new sql.Request();
   request.execute('CARS__list_last', function(err, recordsets, returnValue, affected) {

     if(!err){
       //console.log(recordsets[0]);
       res.status(200).send(JSON.stringify(recordsets[0]));
     }else{
        console.log(err);
       res.status(400).send(err);
     }
   });

});


app.post('/add_element', function (req, res) {

  //console.log("Entro en add add_element");
  //params obligatorios
  if(req.body.marca && req.body.modelo && req.body.enlace_foto && req.body.tipo){

      var request = new sql.Request();
      request.input('marca', sql.NVarChar, req.body.marca.toUpperCase());
      request.input('modelo', sql.NVarChar, req.body.modelo.toUpperCase());

      request.input('year', sql.NVarChar, req.body.year.toUpperCase());
      request.input('nacionalidad_coche', sql.NVarChar, req.body.nacionalidad_coche.toUpperCase());
      
      request.input('tipo', sql.Int, req.body.tipo);
      request.input('enlace_foto', sql.NVarChar, req.body.enlace_foto);
      request.input('campeonato', sql.NVarChar, req.body.campeonato.toUpperCase());
      request.input('competicion', sql.NVarChar, req.body.competicion.toUpperCase());
      request.input('categoria', sql.NVarChar, req.body.categoria.toUpperCase());
      request.input('piloto', sql.NVarChar, req.body.piloto.toUpperCase());
      request.input('nacionalidad_piloto', sql.NVarChar, req.body.nacionalidad_piloto.toUpperCase());
      request.input('copiloto', sql.NVarChar, req.body.copiloto.toUpperCase());
      request.input('nacionalidad_copiloto', sql.NVarChar, req.body.nacionalidad_copiloto.toUpperCase());
      request.input('precio', sql.NVarChar, req.body.precio.toUpperCase());
      request.input('descripcion', sql.NVarChar, req.body.descripcion);
      request.input('fabricante', sql.NVarChar, req.body.fabricante.toUpperCase());

      request.execute('CARS__insert', function(err, recordsets, returnValue, affected) {
          if(!err){
            //console.log(recordsets[0][0]);
            res.status(200).send(recordsets[0][0]);
          }
          else{
            console.log(err);
            res.status(400).send(err);
          }

      });


  }
  else{
    res.status(400).send("Invalid arguments.");
  }


});


app.post('/list_elements', function(req,res){
  console.log(JSON.stringify(req.body));
  var request = new sql.Request();
    
    request.input('marca', sql.NVarChar, req.body.marca.toUpperCase());
    request.input('modelo', sql.NVarChar, req.body.modelo.toUpperCase());
    request.input('year', sql.NVarChar, req.body.year.toUpperCase());
    request.input('nacionalidad_coche', sql.NVarChar, req.body.nacionalidad_coche.toUpperCase());

    if(req.body.tipo1){
      request.input('tipo1', sql.Int, 1);
    }
    else{
      request.input('tipo1', sql.Int, null);
    }

    if(req.body.tipo1){
      request.input('tipo2', sql.Int, 2);
    }
    else{
      request.input('tipo2', sql.Int, null);
    }

    if(req.body.tipo1){
      request.input('tipo3', sql.Int, 3);
    }
    else{
      request.input('tipo3', sql.Int, null);
    }

    request.input('campeonato', sql.NVarChar, req.body.campeonato.toUpperCase());
    request.input('competicion', sql.NVarChar, req.body.competicion.toUpperCase());
    request.input('categoria', sql.NVarChar, req.body.categoria.toUpperCase());
    request.input('piloto', sql.NVarChar, req.body.piloto.toUpperCase());
    request.input('nacionalidad_piloto', sql.NVarChar, req.body.nacionalidad_piloto.toUpperCase());
    request.input('copiloto', sql.NVarChar, req.body.copiloto.toUpperCase());
    request.input('nacionalidad_copiloto', sql.NVarChar, req.body.nacionalidad_copiloto.toUpperCase());
    request.input('precio', sql.NVarChar, req.body.precio.toUpperCase());
    request.input('fabricante', sql.NVarChar, req.body.fabricante.toUpperCase());
    request.input('desde', sql.NVarChar, req.body.desde);

    request.execute('CARS__list', function(err, recordsets, returnValue, affected) {
          if(!err){
            //console.log(recordsets);
            //res.status(200).send(recordsets[0]);
          }
          else{
            console.log(err);
            res.status(400).send(err);
          }

      });
     
      

});



app.post('/delete_element', function (req, res) {

   if(req.body.id){

     var request = new sql.Request();
     request.input('ID', sql.Int, req.body.id);
     request.execute('CARS__delete', function(err, recordsets, returnValue, affected) {
       if(!err){
         res.status(200).send('OK');
       }else{
         res.status(400).send(err);
       }
     });

   }else{
     res.status(400).send("Invalid argument.");
   }

});


app.get('/get_info', function(req, res){
  var request = new sql.Request();
     request.execute('CARS__get_info', function(err, recordsets, returnValue, affected) {
       if(!err){

        //console.log(recordsets[0]);
        res.status(200).send(recordsets[0]);
       }
       else{
        console.log(err);
        res.status(400).send(err);
       }
     });
});





console.log('Server running');