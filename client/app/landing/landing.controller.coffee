'use strict'

angular.module 'brasFeApp'
.controller 'LandingCtrl', ($scope, $state) ->
  ""
  #$scope.awesomeThings = []

  #$http.get('/api/things').success (awesomeThings) ->
    #$scope.awesomeThings = awesomeThings

  at_state = (st)->
    $state.current.name == "session.#{st}"

  $scope.dim_bg = ()->
    at_state("login") ||
    at_state("register") ||
    at_state("reset")

  $scope.landing = ()->
    console.log "here"
