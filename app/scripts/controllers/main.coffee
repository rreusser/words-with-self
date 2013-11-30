'use strict'

@app.controller('MainCtrl', ['Word', '$rootScope', '$scope', (Word, $rootScope, $scope) ->


  $rootScope.wordList ||= undefined

  $scope.fetchWordList = ->
    q = new Parse.Query(Word)
    q.descending('createdAt')
    q.find({
      success: (results) ->
        $rootScope.wordList = results
        $scope.$digest() unless $scope.$$phase
    })


  $scope.delete = (word) ->
    word.destroy({
      success: ->
        i = $rootScope.wordList.indexOf(word)
        $rootScope.wordList.splice(i,1) if i>-1
        $scope.$digest() unless $scope.$$phase
      error: (error)->
        console.log('error encountered:',error)
    })

    


])
