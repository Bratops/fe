'use strict'

angular.module 'brasFeApp'
.controller 'DashboardCtrl', ($scope, $state, menu, sessionServ, growl) ->
  session = sessionServ
  session.warm_up()

  $scope.data =
    menu: menu.data
    role: {}

  $scope.$on "$stateChangeStart", (event, toState, toParams, fromState, fromParams)->
    bs = session.base_state()
    unless toState.name.indexOf(bs) is 0
      event.preventDefault()
    #growl.warning "沒有權限", "警告"

  current_role = (role)->
    roles = $scope.user.roles
    ri = _.findIndex(roles, (r)-> r.id == role.id)
    if ri < 0 then roles[0] else roles[ri]

  $scope.$on "$stateChangeSuccess", (event, toState, toParams, fromState, fromParams)->
    session.auth_user(toState, $state)
    if session.is_valid_state($state)
      user = session.user
      $scope.user = user
      $scope.data.role = current_role(user.role)

  $scope.$on "redirect", (event, data)->
    if data is "dashboard"
      $state.go(data + "." + session.user.role.name)

  $scope.$watch "data.role", (nv, ov)->
    if ov.id isnt nv.id
      session.switch_role(nv.id)

  $scope.$on '$stateNotFound', (event, unfoundState, fromState, fromParams)->
    console.log unfoundState.name
    growl.error "未實作的功能", title: "Oops"
    event.preventDefault()

  $scope.logout = ()->
    session.logout()

