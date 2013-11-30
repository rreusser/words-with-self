@app.directive('mwEntry', [() -> {
  scope: {
    definition: '=definition'
  },
  link: (scope, elem, attrs) ->
    def = scope.definition
  templateUrl: 'views/definition.html'
}])
