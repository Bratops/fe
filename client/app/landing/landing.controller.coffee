'use strict'

angular.module 'brasFeApp'
.controller 'LandingCtrl', ($scope, $location, $anchorScroll) ->
  ""
  #$scope.awesomeThings = []

  #$http.get('/api/things').success (awesomeThings) ->
    #$scope.awesomeThings = awesomeThings
  $scope.scrollTo = (id)->
    old = $location.hash()
    $location.hash(id)
    $anchorScroll()
    $location.hash(old)
