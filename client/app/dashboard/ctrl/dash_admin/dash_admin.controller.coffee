'use strict'

angular.module 'brasFeApp'
.controller 'DashAdminCtrl', ($scope, $state) ->
  $scope.message = 'Hello admin'

  $scope.$on "$stateChangeStart", (event, toState, toParams, fromState, fromParams)->
    console.log $state.current.name
