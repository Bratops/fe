'use strict'

angular.module 'brasFeApp'
.controller 'DashMenuCtrl', ($scope, $state, menu) ->
  $scope.$on "$stateChangeSuccess", (event, toState, toParams, fromState, fromParams)->
    if $state.includes("dashboard.*")
      menu.reload()
      $scope.data = menu.data
