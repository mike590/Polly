var app = angular.module('polly', []);

app.config(["$routeProvider", function($routeProvider){
  // $routeProvider.
  // when('/', {templateUrl: "", controller: ""}).
  // otherwise({redirectTo: '/'});
}]);

app.factory('rhymer', [function(){
  var rhymer = {
    syls: [],
    pattern: ""
  };
  return rhymer;
}]);

app.factory('pronunciations', [function(){
  var pronunciations = {
    list: []
  };
  return pronunciations;
}]);

app.controller("exampleController", ["$scope", "rhymer", function($scope, rhymer){

}]);

app.directive("searcher", ["$http", "pronunciations", "rhymer", function($http, pronunciations, rhymer){
  return {
    restrict: "A",
    replace: true,
    templateUrl: "searcher.html",
    link: function(scope, elem, attr){

      scope.getProns = function(){
        var url = '/search/' + scope.rhyme;
        $http.get(url).
          success(function(data) {
            scope.prons.list = data.list;
            scope.rhymer.syls = data.list[0].split("-");
            scope.rhymer.pattern = data.list[0];
          }).
          error(function(data) {});
      };

      scope.prons = pronunciations;
      scope.rhymer = rhymer;

      var newRhyme = function(){
        scope.rhyme = ""
      };
      newRhyme();
    }
  }
}]);

app.directive("sylselect", ['rhymer', function(rhymer){
  return {
    restrict: "A",
    replace: true,
    templateUrl: "sylselect.html",
    link: function(scope, elem, attr){
      scope.rhymer = rhymer;
      scope.syls = rhymer.syls;

      scope.tester = function(){
        console.log(scope.rhymer);
        console.log(scope.syls);
      };
      
    }
  }
}]);