@app.controller('DefinitionsCtrl', ['$scope', ($scope) ->

  $scope.id = ->
    $scope.entry.find('> hw').attr('hindex')

  $scope.headword = ->
    $scope.entry.find('> hw')
    
])
