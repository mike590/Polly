app.get('/', function(req, res){
  res.sendFile(path.join(__dirname + 'index.html'))
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
