'use strict'

@app = angular.module('wordsApp', [
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'ngRoute'
])
  .config(['$routeProvider', ($routeProvider) ->
    $routeProvider
      .when '/',
        templateUrl: 'views/main.html'
        controller: 'MainCtrl'
      .when '/define/:term',
        templateUrl: 'views/define.html'
        controller: 'DefinitionCtrl'
      .otherwise
        redirectTo: '/'
  ]).run(['$rootScope', ($rootScope) ->

    Parse.initialize(
      "sBawmQQJucrxAslWUESc8HpTXq0V47OLtccIhCjY",
      "pSLqtsWzlQMplapQDwhRebHRlCjiy9TEYi0hM4G7"
    )

    $rootScope.currentUser = Parse.User.current()

  ])
