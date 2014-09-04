'use strict'

angular.module 'brasFeApp'
.controller 'DashAdminCtrl', ($scope, $state, dashUser) ->
  state_base = "dashboard.admin"

  $scope.data =
    users: dashUser.users

  $scope.$on "$stateChangeStart", (event, toState, toParams, fromState, fromParams)->
    #console.log $state.current.name

  $scope.$on "$stateChangeSuccess", (event, toState, toParams, fromState, fromParams)->
    if toState.name is "#{state_base}.users"
      dashUser.load_users()

  $scope.$on "users_loaded", ()->
    $scope.data.users = dashUser.users

  $scope.leaves = ()->
    return false unless $scope.user?
    !$state.is("dashboard.#{$scope.user.role.name}")
