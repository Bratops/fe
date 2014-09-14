'use strict'

angular.module 'brasFeApp'
.controller 'DashTeacherCtrl', ($scope) ->
  state_base = "dashboard.teacher"

  $scope.$on "$stateChangeSuccess", (event, toState, toParams, fromState, fromParams)->
    ""
