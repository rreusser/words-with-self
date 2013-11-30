@app.controller('WordsCtrl', ['$location', '$scope', '$rootScope', 'Word', ($location, $scope, $rootScope, Word) ->

  $scope.term = ''

  $scope.submit = ->
    $location.url('/define/'+$scope.term)

  $scope.fetchWordList() if $scope.wordList==undefined

  $scope.define = (term) ->
    $location.url('/define/'+term)

])
