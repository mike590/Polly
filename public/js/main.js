var app = angular.module('polly', []);

app.config(["$routeProvider", function($routeProvider){
  // $routeProvider.
  // when('/complete/:word/:pron/:pattern', {template: "<div completematch></div>"}).
  // when('/', {redirectTo: '/complete/sample/1/11'}).
  // otherwise({redirectTo: '/complete/sample/1/11'});
}]);

app.factory('rhymer', ["$http", function($http){
    var rhymer = {
    syls: [{text: "Enter", disabled: true}, {text: "a", disabled: true}, {text: "word", disabled: true}],
    usableSyls: 0,
    pronunciations: [],
    selectedPronIndex: 1,
    helpProns: false,
    helpSyls: false,
    helpWholeMatch: false,
    helpSplitMatch: false,
    closeHelp: function(index){
      var helps = ["helpProns", "helpSyls", "helpWholeMatch", "helpSplitMatch"];
      rhymer[helps[index]] = false;
    },
    clickPron: function(pron, index){
      if(pron.exact){
        rhymer.selectedPronIndex = index;
        // rhymer.helpProns = false;
        rhymer.selectPron(pron);
      }
    },
    highlightPron: function(){
      var prons = document.querySelectorAll("#pron_list li");
      for(i = 0; i < prons.length; ++i){
        prons[i].id = "";
      }
      prons[rhymer.selectedPronIndex].id = "highlight";
    },
    selectPron: function(pron){
      if(pron.token){
        return null;
      }
      rhymer.syls = [];
      var exacts;
      var syls = pron.text.split("-");
      if(pron.exact){
        exacts = pron.exact.split("-");
        syls.forEach(function(el, ind, arr){
          rhymer.syls.push({text: el, exact: exacts[ind], use: true});
        });
        rhymer.getRhymes();
      } else {
        rhymer.usableSyls = 0;
        rhymer.syls.push(pron);
        rhymer.cMRhymes = ["Word Not Found"];
        rhymer.splitRhymes = [false];
      }
    },
    getProns: function(rhyme){
      var url = '/search/' + rhyme;
      $http.get(url).
      success(function(data) {
        rhymer.pronunciations = data.list;
        rhymer.selectedPronIndex = 1;
        rhymer.selectPron(data.list[1]);
      }).
      error(function(data) {});
    },
    compilePattern: function(){
      pattern = '';
      rhymer.syls.forEach(function(el, ind, arr){
        if(el.use){
          pattern += el.exact;
        } else {
          pattern += '^';
        }
        if(ind != rhymer.syls.length - 1){
          pattern += '-';
        }
      });
      return pattern;
    },
    getRhymes: function(index){
      var pattern = rhymer.compilePattern();
      var url = '/rhyme/' + pattern;
      $http.get(url).
      success(function(data) {

        rhymer.usableSyls = 0;
        rhymer.syls.forEach(function(el, ind, arr){
          if(el.use){ rhymer.usableSyls += 1}
        });
        rhymer.cMRhymes = data.completeMatch;
        rhymer.splitRhymes = data.splitMatch;
        rhymer.highlightPron();
      }).
      error(function(data) {});
    },
    cMRhymes: [],
    splitRhymes: []
  };
  return rhymer;
}]);

app.controller("routeCtlr", ["$routeParams", 'rhymer', function($routeParams, rhymer){

}]);

app.directive("searcher", ["$http", "rhymer", function($http, rhymer){
  return {
    restrict: "A",
    replace: true,
    templateUrl: "searcher.html",
    link: function(scope, elem, attr){

      scope.rhymer = rhymer;
      scope.rhyme = "read";

      // press enter on text field should send data
      document.getElementById('rhyme_input').addEventListener('keydown', function(e){
        if(e.keyCode === 13){
          rhymer.getProns(scope.rhyme);
        }
      });

      document.getElementById('rhyme_input').addEventListener('click', function(e){
        document.getElementById('rhyme_input').select();
      });

      scope.refreshHelp = function(){
        rhymer.helpProns = true;
        rhymer.helpSyls = true;
        rhymer.helpWholeMatch = true;
        rhymer.helpSplitMatch = true;
        scope.rhyme = "graduate";
        rhymer.getProns(scope.rhyme);
      };

      rhymer.getProns(scope.rhyme);

    }
  }
}]);

app.directive("sylselect", ['rhymer', function(rhymer){
  return {
    restrict: "A",
    replace: true,
    templateUrl: "sylselect.html",
    link: function(scope, elem, attr){

      scope.clickSyl = function(index){
        var syl = scope.rhymer.syls[index];
        if(syl.disabled != true && (rhymer.usableSyls != 1 || !syl.use)){
          // rhymer.helpSyls = false;
          // Alternate syl class and property
          syl.use = !syl.use;
          var syl_dom = document.getElementById("syl" + index)
          new_class = syl.use ? "use" : "dont"
          syl_dom.className = new_class + " hand";
          rhymer.getRhymes();
        }
      };

      scope.rhymer = rhymer;

    }
  }
}]);

app.directive("completematch", ['rhymer', function(rhymer){
  return{
    restrict: "A",
    replace: true,
    templateUrl: "completematch.html",
    link: function(scope, elem, ettr){
      scope.rhymer = rhymer;
    }
  }
}]);

app.directive("splitmatch", ['rhymer', function(rhymer){
  return{
    restrict: "A",
    replace: true,
    templateUrl: "splitmatch.html",
    link: function(scope, elem, ettr){
      scope.rhymer = rhymer;
    }
  }
}]);
