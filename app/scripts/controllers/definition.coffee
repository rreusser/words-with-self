@app.controller('DefinitionCtrl', ['$routeParams', '$location', '$http', '$interpolate', '$scope', '$rootScope', 'Word', ($routeParams, $location, $http, $interpolate, $scope, $rootScope, Word) ->

  $scope.id = ->
    $scope.entry.find('> hw').attr('hindex')

  $scope.headword = ->
    $scope.entry.find('> hw')
    
  $scope.mwApiKey = 'fcb82ca9-59ab-48b8-9185-1ae25bf70fa6'
  definitionEndpoint = $interpolate 'http://notrocketscience.herokuapp.com/dictionary.json?term={{term}}&callback=JSON_CALLBACK'

  $scope.term = "test"
  $scope.definitions = []

  unpack = (data) ->
    defs = []
    window.xml = xml = $(data)

    addChildTo =  ->
      newEl = {
        parent: @cur,
        depth: @cur.depth+1,
        children: [],
        text: '',
        label: ''
      }
      @cur.children.push( newEl )
      @cur = newEl
      newEl

    endChild = ->
      @cur = @cur.parent

    nextAtDepth = (d) ->
      if @cur.depth>=d
        endChild() while @cur.depth >= d
        addChildTo()
      else if @cur.depth < d
        addChildTo() while @cur.depth < d

    for entry in entries = $(xml).find('> entry')
      #console.log( entry )
      $entry = $(entry)
      result = {}
      hw = $entry.find('> hw')
      result.hw = hw[0].innerHTML.replace(/\*/g,'·')
      result.hindex = hw.attr('hindex')
      result.fl = $entry.find('> fl')[0].innerHTML


      def = $entry.find('> def')[0]

      @cur = {
        parent: undefined,
        children: [],
        depth: 0,
        text: ''
      }
      @root = @cur

      for n in def.childNodes
        if n.nodeType==1
          switch n.nodeName
            when 'DATE'
              x=1 # placeholder = do nothing...
            when 'SN'
              for num in $.trim(n.innerText).split(/\s+/)
                if num.match( /^[0-9]+\s*$/ )
                  nextAtDepth(1)
                else if num.match(/^[a-z]+\s*$/)
                  nextAtDepth(2)
                else if num.match(/^\([0-9]+\)\s*$/)
                  nextAtDepth(3)
                else
                @cur.label = num
            else
              @cur.text += n.innerText.replace(/:/g,': ')

      result.root = @root
      defs.push(result)

    #console.log defs
    defs

    
  $scope.lookUp = ->

    $scope.term = $routeParams.term

    $http({
      method: 'JSONP',
      url: definitionEndpoint($scope)

    }).success((data,status) ->
      $scope.definitions = unpack(data['xml'])

    ).error((data,status) ->
      console.log(data,status)
      $scope.definition = undefined
    )

  $scope.lookUp()

  $scope.submit = ->
    $location.url('/define/'+$scope.term)


  $scope.store = ->
    w = new Word
    w.set('term', $scope.term)
    w.setACL(new Parse.ACL(Parse.User.current()))
    w.save(null,{
      success: ((data) ->
        #console.log('stored!')
      )
    })


])
