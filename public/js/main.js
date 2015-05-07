var app = angular.module('polly', []);

app.config(["$routeProvider", function($routeProvider){
  // $routeProvider.
  // when('/', {templateUrl: "", controller: ""}).
  // otherwise({redirectTo: '/'});
}]);

app.factory('rhymer', ["$http", function($http){
  var rhymer = {
    syls: [],
    pronunciations: [],
    selectPron: function(pron){
      rhymer.syls = [];
      var syls = pron.text.split("-");
      var exacts = pron.exact.split("-");
      syls.forEach(function(el, ind, arr){
        rhymer.syls.push({text: el, exact: exacts[ind], use: true});
      });
    },
    getProns: function(rhyme){
      var url = '/search/' + rhyme;
      $http.get(url).
      success(function(data) {
        rhymer.pronunciations = data.list;
        rhymer.selectPron(data.list[0]);
        rhymer.getCMRhymes();
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
      console.log(pattern);
      return pattern;
    },
    getCMRhymes: function(){
      var pattern = rhymer.compilePattern();
      var url = '/rhyme/' + pattern;
      console.log("Accessing %s", url);
      $http.get(url).
      success(function(data) {
        console.log("Just got back");
        cMRhymes = data.rhymes;
        cMRhymes.forEach(function(el, ind, arr){
          console.log(el);
        });
      }).
      error(function(data) {});
    },
    cMRhymes: []
  };
  return rhymer;
}]);

app.directive("searcher", ["$http", "rhymer", function($http, rhymer){
  return {
    restrict: "A",
    replace: true,
    templateUrl: "searcher.html",
    link: function(scope, elem, attr){

      

      scope.rhymer = rhymer;
      scope.rhyme = "";

      // press enter on text field should send data
      document.getElementById('rhyme_input').addEventListener('keydown', function(e){
        if(e.keyCode === 13){
          rhymer.getProns(scope.rhyme);
        }
      });

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
        syl.use = !syl.use;
        var syl_dom = document.getElementById("syl" + index)
        new_class = syl.use ? "use" : "dont"
        syl_dom.className = new_class;
        rhymer.getCMRhymes();
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