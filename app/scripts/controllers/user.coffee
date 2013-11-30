'use strict'

@app.controller('UserCtrl', ['$rootScope','$scope', ($rootScope,$scope) ->

  $rootScope.userSignedIn = ->
    $rootScope.currentUser != undefined and $rootScope.currentUser != null

  $scope.signOut = ->
    Parse.User.logOut()
    $rootScope.wordList = []
    $rootScope.currentUser = undefined

  $scope.signUp = ->

    user = new Parse.User()
    user.set("username", $scope.username )
    user.set("password", $scope.password )

    user.signUp(null, {
      success: (user) ->
        $rootScope.currentUser = Parse.User.current()
        $('#sign-up-modal').foundation('reveal','close')
        $scope.$apply()
      , error: (user,error) ->
        console.log( 'oops: ',error)
    })


  $scope.signIn = ->
    Parse.User.logIn($scope.username, $scope.password, {
      success: (user) ->
        $rootScope.currentUser = Parse.User.current()
        $('#sign-in-modal').foundation('reveal','close')
        $scope.fetchWordList()
      , error: (user, error) ->
        alert( error )
    })

])

