@app.controller('WordsCtrl', ['$location', '$http', '$interpolate', '$scope', '$rootScope', 'Word', ($location, $http, $interpolate, $scope, $rootScope, Word) ->

  $scope.term = ''

  $scope.submit = ->
    $location.url('/define/'+$scope.term)


  allWords = new Parse.Query(Word)
  #allWords = {"results":[{"term":"abreaction","createdAt":"2013-11-30T17:32:46.759Z","updatedAt":"2013-11-30T17:32:46.759Z","objectId":"RwbqgEofQn","ACL":{"wPckTBXd7X":{"read":true,"write":true}}}]}


  if $rootScope.wordList == undefined
    $rootScope.wordList = []

    allWords.each (data) ->
    #for data in allWords['results']
      $rootScope.wordList.push({
        term: data.get('term')
        #term: data.term
      })
    $scope.$apply()

  $scope.define = (term) ->
    $location.url('/define/'+term)

])
