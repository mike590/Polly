var express = require('express');
var app = express();
var debug = require('debug')('global');
var doc = require('./wordlist.json');

// app.use(express.logger('dev'));
app.use(express.static(__dirname + '/public/views'));
app.use(express.static(__dirname + '/public/views/templates'));
app.use(express.static(__dirname + '/public/js'));
app.use(express.static(__dirname + '/public/styles'));

// helpers
function completeMatchRhyme(patternArr){
  var prePatternArr = patternArr;
  // var prePatternArr = req.params.pattern.split("-");
  var done = false;
  var splice_count = 0;
  var rhymes = [];
  prePatternArr.forEach(function(el, ind, arr){
    if(!done && el === "^"){
      splice_count += 1;
    } else {
      done = true;
    }
  });
  prePatternArr.splice(0, splice_count);
  var pattern = prePatternArr.join("-").replace(/\^/g, "[\\wəēīȯᵊüāäōœˈˌ]+");
  var regExPattern = new RegExp(pattern);
  var syl_count = pattern.split("-").length;
  function rhyme(word){
    word.exacts.forEach(function(ex_el, ex_ind, ex_arr){
      var ex_arr = ex_el.split("-");
      var subString = "";
      ex_arr.forEach(function(ex_syl, ex_ind, ex_arr){
        if(ex_arr.length - ex_ind <= syl_count){
          subString += ex_syl;
          subString += "-"
        }
      });
      subString = subString.substring(0, subString.length -1);
      if(subString.match(regExPattern)){
        rhymes.push(word.word);
        return;
      }
    });
    return;
  }
  doc.forEach(function(w_el, w_ind, w_arr){
    rhyme(w_el);
  });
  var uniqueRhymes = rhymes.filter(function(elem, pos) {
    return rhymes.indexOf(elem) == pos;
  }); 
  return rhymes.sort();
}

function splitMatchRhyme(sylArr){
  var rhymes = [];
  sylArr.forEach(function(syl_ex){
    if(syl_ex !== "^"){
      var tempSylArr = [];
      doc.forEach(function(word){
        word.exacts.forEach(function(word_ex){
          if(word_ex.split("-").length === 1 && word_ex === syl_ex){
            tempSylArr.push(word.word);
          }
        });
      });
      // get rid of uniques in tempSylArr
      if(tempSylArr.length === 0){
        tempSylArr.push("Nothing Found");
      }
      rhymes.push(tempSylArr.sort());
    }
  });
  return rhymes;
}


app.get('/', function(req, res){
  res.sendFile(__dirname + 'index.html')
});

app.get('/search', function(req, res){
  res.json({list: ["Enter a word", "to see its", "pronunciations"]});
});

app.get('/search/:word', function(req, res){
  var returnList = [];
  var matchWord = req.params.word;
  doc.forEach(function(el, ind, arr){
    if(matchWord === el.word){
      el.pron.forEach(function(p_el, p_ind, p_arr){
        el.exacts.forEach(function(ex_el, ex_ind, ex_arr){
          if(p_ind === ex_ind){
            returnList.push({text: p_el, exact: ex_el});
          }
        });
      });
    }
  });
  if(returnList.length === 0){
    returnList = [{text: "Not in Dictionary", disabled: true}];
  }
  res.json({list: returnList});
});

app.get('/rhyme/:pattern', function(req, res){
  var completeMatchRhymes = completeMatchRhyme(req.params.pattern.split("-"));
  var splitMatchRhymes = splitMatchRhyme(req.params.pattern.split("-"));
  res.json({completeMatch: completeMatchRhymes, splitMatch: splitMatchRhymes});
});

var server = app.listen(9292, function(){
  var host = server.address().address;
  var port = server.address().port;

  debug('Example app listening at http://%s:%s', host, port);
});