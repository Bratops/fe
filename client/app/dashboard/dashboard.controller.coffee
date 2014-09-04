'use strict'

angular.module 'brasFeApp'
.controller 'DashboardCtrl', ($scope, $state, sessionServ, growl) ->
  sessionServ.warm_up()

  $scope.$on "$stateChangeStart", (event, toState, toParams, fromState, fromParams)->
    #console.log $state.current.name
    #event.preventDefault()
    #growl.warning "沒有權限", "警告"

  $scope.$on "$stateChangeSuccess", (event, toState, toParams, fromState, fromParams)->
    if $state.includes("dashboard.*")
      $scope.user = sessionServ.user
      ri = _.findIndex($scope.user.roles, (r)-> r.id == $scope.user.role.id)
      if ri >= 0
        $scope.role = $scope.user.roles[ri]
      else
        console.log $scope.user

  $scope.$on "redirect", (event, data)->
    if data is "dashboard"
      $state.go(data + "." + sessionServ.user.role.name)

  $scope.$watch "role", (nv, ov)->
    if ov and (nv.id isnt ov.id)
      sessionServ.switch_role(nv.id)

  $scope.logout = ()->
    sessionServ.logout()

  $scope.$on '$stateNotFound', (event, unfoundState, fromState, fromParams)->
    growl.error "未實作的功能", title: "Oops"
    event.preventDefault()
