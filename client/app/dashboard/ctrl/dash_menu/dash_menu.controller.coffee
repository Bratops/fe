'use strict'

angular.module 'brasFeApp'
.controller 'DashMenuCtrl', ($scope, $state, menu) ->

  $scope.data = menu.data

  $scope.$on "$stateChangeSuccess", (event, toState, toParams, fromState, fromParams)->
    if $state.includes("dashboard.**")
      menu.load()
      $scope.data = menu.data

  $scope.$on "role_switched", ()->
    menu.reload()

  $scope.menu_click = (item)->
    $scope.clicked = item
    menu.data.clicked = item
    state = "dashboard.#{menu.role()}.#{item.link}"
    $state.transitionTo(state)

