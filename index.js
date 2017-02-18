
var express = require('express');
var app = express();
var bodyParser = require('body-parser');
var server = require('http').Server(app);
var sql = require('mssql');

var vars = {
   	domain:'https://coleccioncoches.azurewebsites.net/',
   	server_port: 80,
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


app.use(express.static('/')); //Static server of the interface




app.get('/list_elements', function (req, res) {

   var request = new sql.Request();
   request.input('onlyEnableds', sql.Int, 1);
   request.output('outputCODE', sql.Int);
   request.execute('CARS__list', function(err, recordsets, returnValue, affected) {

     if(!err){
       res.status(200).send(JSON.stringify(recordsets[0]));
     }else{
       res.status(400).send(err);
     }
   });

});