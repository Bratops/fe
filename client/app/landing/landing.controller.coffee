'use strict'

angular.module 'brasFeApp'
.controller 'LandingCtrl', ($scope, $state, sessionServ, bulletin, menu) ->
  sessionServ.warm_up()
  bulletin.load_pub()

  $scope.data =
    menu: menu.data
    user: sessionServ.user
    msgc: bulletin.data

  at_state = (st)->
    $state.current.name == "session.#{st}"

  $scope.dim_bg = ()->
    at_state("login") ||
    at_state("register") ||
    at_state("reset") ||
    at_state("student")

  $scope.loggedin = ()->
    sessionServ.is_user

  $scope.logout = ()->
    sessionServ.logout()

  $scope.$on "$stateChangeStart",
  (event, toState, toParams, fromState, fromParams)->
    #console.log "ere"

  $scope.menu_clicked = ()->
    menu.data.clicked.name?

  $scope.toggle_menu_video = ()->
    menu.data.tube.visible = !menu.data.tube.visible
    if menu.data.tube.player?
      if menu.data.tube.visible
        menu.data.tube.player.playVideo()
      else
        menu.data.tube.player.stopVideo()

