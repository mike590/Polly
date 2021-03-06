var express = require('express');
var app = express();
var doc = require('./wordlist.json');

// app.use(express.logger('dev'));
app.use(express.static(__dirname + '/public/views'));
app.use(express.static(__dirname + '/public/views/templates'));
app.use(express.static(__dirname + '/public/js'));
app.use(express.static(__dirname + '/public/styles'));
app.use(express.static(__dirname + '/public/fonts'));
app.use(express.static(__dirname + '/public/images'));

// helpers
function completeMatchRhyme(patternArr){
  var prePatternArr = patternArr;
  // var prePatternArr = req.params.pattern.split("-");
  var rhymes = [];
  // Remove leading unselected syllables
  var done = false;
  var splice_count = 0;
  prePatternArr.forEach(function(el, ind, arr){
    if(!done && el === "^"){
      splice_count += 1;
    } else {
      done = true;
    }
  });
  prePatternArr.splice(0, splice_count);
  // Remove trailing unselected syllables
  prePatternArr.reverse();
  var done = false;
  var splice_count = 0;
  prePatternArr.forEach(function(el, ind, arr){
    if(!done && el === "^"){
      splice_count += 1;
    } else {
      done = true;
    }
  });
  prePatternArr.splice(0, splice_count);
  // Set it forward again
  prePatternArr.reverse();

  var pattern = prePatternArr.join("-").replace(/\^/g, "[\\wəēīȯᵊüāäōœˈˌ]+");
  var regExPattern = new RegExp(pattern);
  var syl_count = pattern.split("-").length;
  function rhyme(word){
    word.exacts.forEach(function(ex_el, ex_ind, ex_arr){
      var ex_syl_arr = ex_el.split("-");
      var subString = "";
      ex_syl_arr.forEach(function(ex_syl_el, ex_syl_ind, ex_syl_arr){
        if(ex_syl_arr.length - ex_syl_ind <= syl_count){
          subString += ex_syl_el;
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
  function remove_duplicates(arr){
    return arr.filter(function (value, index, self) {
      return self.indexOf(value) === index;
    });
  };
  return remove_duplicates(rhymes).sort();
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
  function remove_duplicates(arr){
    return arr.filter(function (value, index, self) {
      return self.indexOf(value) === index;
    });
  };
  return remove_duplicates(rhymes).sort();
}


app.get('/', function(req, res){
  res.sendFile(__dirname + 'index.html')
});

app.get('/search', function(req, res){
  res.json({list: ["Enter a word", "to see its", "pronunciations"]});
});

app.get('/search/:word', function(req, res){
  var returnList = [];
  var matchWord = req.params.word.toLowerCase();
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
    returnList.unshift({text: "Pronunciations", token: true});
    res.json({list: returnList});
  } else {
    returnList.sort(function(a, b){
      return a.text.length - b.text.length;
    });
    returnList.unshift({text: "Pronunciations", token: true});
    res.json({list: returnList});
  }
});

app.get('/rhyme/:pattern', function(req, res){
  var completeMatchRhymes = completeMatchRhyme(req.params.pattern.split("-"));
  var splitMatchRhymes = splitMatchRhyme(req.params.pattern.split("-"));
  res.json({completeMatch: completeMatchRhymes, splitMatch: splitMatchRhymes});
});

var server = app.listen(process.env.PORT || 9292, function(){
  var host = server.address().address;
  var port = server.address().port;

});
