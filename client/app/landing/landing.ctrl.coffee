"use strict"
angular.module("brasFeApp").classy.controller
  name: "LandingCtrl"
  inject:
    $scope: "$"
    $state: "st"
    sessionServ: "session"
    bulletin: "bull"
    menu: "menu"

  init: ->
    @session.warm_up()
    @bull.load_pub()
    @$.data =
      menu: @menu.data
      user: @session.user
      msgc: @bull.data

    @$.$on "$stateChangeStart", @_on_st_change

  _on_st_change: (event, toState, toParams, fromState, fromParams)->
    #console.log "landing->", toState.name

  _at_state: (st)->
    @st.is("session.#{st}")

  dim_bg: ()->
    @_at_state("login") ||
    @_at_state("register") ||
    @_at_state("reset") ||
    @_at_state("student")

  loggedin: ()->
    @session.is_user

  logout: ()->
    @session.logout()

  menu_clicked: ()->
    @menu.data.clicked.name?

  toggle_menu_video: ()->
    @menu.data.tube.visible = !@menu.data.tube.visible
    if @menu.data.tube.player?
      if @menu.data.tube.visible
        @menu.data.tube.player.playVideo()
      else
        @menu.data.tube.player.stopVideo()

