'use strict'

angular.module 'brasFeApp'
.controller 'DashboardCtrl', ($scope, $state, sessionServ) ->
  sessionServ.warm_up()

  $scope.$on "$stateChangeStart", (event, toState, toParams, fromState, fromParams)->
    console.log $state.current.name
    #event.preventDefault()
    #growl.warning "沒有權限", "警告"

  $scope.$on "$stateChangeSuccess", (event, toState, toParams, fromState, fromParams)->
    if $state.includes("dashboard.*")
      $scope.user = sessionServ.user
      ri = _.findIndex $scope.user.roles, (r)-> r.id == $scope.user.role.id
      $scope.role = $scope.user.roles[ri]

  $scope.$on "redirect", (event, data)->
    if data is "dashboard"
      $state.go(data + "." + sessionServ.user.role.name)

  $scope.$watch "role", (nv, ov)->
    if ov and (nv.id isnt ov.id)
      sessionServ.switch_role(nv.id)

  $scope.logout = ()->
    sessionServ.logout()
