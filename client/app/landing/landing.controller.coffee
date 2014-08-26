'use strict'

angular.module 'brasFeApp'
.controller 'LandingCtrl', ($scope, $state) ->
  ""
  #$scope.awesomeThings = []

  #$http.get('/api/things').success (awesomeThings) ->
    #$scope.awesomeThings = awesomeThings

  $scope.at_state = (st)->
    $state.current.name == "landing.#{st}"

  $scope.dim_bg = ()->
    $scope.at_state("login") || $scope.at_state("register")
