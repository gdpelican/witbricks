@witbricks.controller 'BricksCtrl', ($scope, $http) ->

  $scope.index = ->
    $http.get('/bricks').success (data) -> 
      $scope.bricks = data

  $scope.show = (id) ->
    $http.get("/bricks/#{id}").success (data) -> 
      $scope.current = data

  $scope.promote = ->
    $scope.current.promote = true
    $scope.update()

  $scope.create = ->
    $http.post("/bricks", { brick: $scope.current }).success -> 
      $scope.resync()

  $scope.update = ->
    $http.put("/bricks/#{$scope.current.id}", { brick: $scope.current }).success ->
      $scope.resync()

  $scope.new = -> $scope.current = {}
  $scope.clear = -> $scope.current = null
  $scope.resync = -> $scope.index() and $scope.clear()
  $scope.isCurrent = (id) -> $scope.current && $scope.current.id == id
