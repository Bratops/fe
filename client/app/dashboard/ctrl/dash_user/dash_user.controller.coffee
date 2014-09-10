'use strict'

angular.module 'brasFeApp'
.controller 'DashUserCtrl', ($scope, $state, sessionServ) ->
  state_base = "dashboard.user"

  $scope.$on "$stateChangeSuccess", (event, toState, toParams, fromState, fromParams)->
    if $state.is "#{state_base}"
      console.log sessionServ.user

