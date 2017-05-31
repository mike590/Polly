var express = require('express');
var mongoose = require('mongoose');
var morgan = require('morgan');
var app = express();

var doc = require('./wordlist.json');


// app.use(express.logger('dev'));
app.use(express.static(__dirname + '/public/views'));
app.use(express.static(__dirname + '/public/views/templates'));
app.use(express.static(__dirname + '/public/js'));
app.use(express.static(__dirname + '/public/styles'));
app.use(express.static(__dirname + '/public/fonts'));
app.use(express.static(__dirname + '/public/images'));

var server = app.listen(process.env.PORT || 9292, function(){
  var host = server.address().address;
  var port = server.address().port;

});
