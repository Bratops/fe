'use strict'

angular.module 'brasFeApp'
.controller 'DashboardCtrl', ($scope, $state, sessionServ, growl) ->
  sessionServ.warm_up()

  $scope.$on "$stateChangeStart", (event, toState, toParams, fromState, fromParams)->
    #console.log $state.current.name
    #event.preventDefault()
    #growl.warning "沒有權限", "警告"

  current_role = (role)->
    roles = $scope.user.roles
    ri = _.findIndex(roles, (r)-> r.id == role.id)
    if ri < 0 then roles[0] else roles[ri]

  $scope.$on "$stateChangeSuccess", (event, toState, toParams, fromState, fromParams)->
    sessionServ.auth_user($state)
    if $state.includes("dashboard.**")
      user = sessionServ.user
      $scope.user = user
      $scope.role = current_role(user.role)

  $scope.$on "redirect", (event, data)->
    if data is "dashboard"
      $state.go(data + "." + sessionServ.user.role.name)

  $scope.$watch "role", (nv, ov)->
    if ov and (nv.id isnt ov.id)
      sessionServ.switch_role(nv.id)

  $scope.logout = ()->
    sessionServ.logout()

  $scope.$on '$stateNotFound', (event, unfoundState, fromState, fromParams)->
    console.log unfoundState.name
    growl.error "未實作的功能", title: "Oops"
    event.preventDefault()
