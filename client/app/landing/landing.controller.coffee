'use strict'

angular.module 'brasFeApp'
.controller 'LandingCtrl', ($scope, $state, sessionServ, bulletin) ->
  sessionServ.warm_up()
  bulletin.load_pub()

  $scope.data =
    user: sessionServ.user
    msgc: bulletin.data

  at_state = (st)->
    $state.current.name == "session.#{st}"

  $scope.dim_bg = ()->
    at_state("login") ||
    at_state("register") ||
    at_state("reset")

  $scope.loggedin = ()->
    sessionServ.is_user

  $scope.logout = ()->
    sessionServ.logout()

  $scope.$on "$stateChangeStart",
  (event, toState, toParams, fromState, fromParams)->
    #console.log "ere"
