var express = require('express');
var app = express();
var debug = require('debug')('global');
var doc = require('./parses/protolist.json')

// app.use(express.logger('dev'));
app.use(express.static(__dirname + '/public/views'));
app.use(express.static(__dirname + '/public/views/templates'));
app.use(express.static(__dirname + '/public/js'));
app.use(express.static(__dirname + '/public/styles'));

app.get('/', function(req, res){
  res.sendFile(__dirname + 'index.html')
});

app.get('/search', function(req, res){
  // doc.list.forEach(function(el, ind, arr){

  // });
  res.json({list: ["Enter a word", "to see its", "pronunciations"]});
});

app.get('/search/:word', function(req, res){
  var returnList = [];
  var matchWord = req.params.word;
  doc.list.forEach(function(el, ind, arr){
    if(matchWord === el.word){
      returnList = el.pron
    }
  });
  if(returnList.length === 0){
    returnList = ["Not in Dictionary"];
  }
  res.json({list: returnList});
});

var server = app.listen(9292, function(){
  var host = server.address().address;
  var port = server.address().port;

  debug('Example app listening at http://%s:%s', host, port);
});