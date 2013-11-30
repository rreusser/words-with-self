@app.directive('autoFillSync', ['$timeout', ($timeout) -> {
  require: 'ngModel',
  link: (scope, elem, attrs, ngModel) ->
    $timeout (->
      ngModel.$setViewValue(elem.val()) if ngModel.$pristine
    ), 500
}])
