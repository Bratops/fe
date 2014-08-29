'use strict'

angular.module 'brasFeApp'
.controller 'LandingCtrl', ($scope, $state, sessionServ) ->
  #$http.get('/api/things').success (awesomeThings) ->
    #$scope.awesomeThings = awesomeThings

  sessionServ.check_local()

  at_state = (st)->
    $state.current.name == "session.#{st}"

  $scope.dim_bg = ()->
    at_state("login") ||
    at_state("register") ||
    at_state("reset")

  $scope.loggedin = ()->
    sessionServ.loggedin()

  $scope.logout = ()->
    sessionServ.logout()

  $scope.$on "$stateChangeStart",
  (event, toState, toParams, fromState, fromParams)->
    console.log "ere"
