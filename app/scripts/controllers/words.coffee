@app.controller('WordsCtrl', ['$scope', '$rootScope', ($scope,$rootScope) ->

  $scope.lookUp = ->
    alert($scope.term)
    
])
