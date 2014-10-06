"use strict"
angular.module("brasFeApp").classy.controller
  name: "DashMenuCtrl"

  inject:
    $scope: "$"
    $state: "st"
    menu: "menu"

  init: ->
    @$.data = @menu.data
    @$.$on "$stateChangeSuccess", @_on_state_changed
    @$.$on "role_switched", @_on_role_changed

  _on_state_changed: (event, toState, toParams, fromState, fromParams)->
    if @st.includes("dashboard.**")
      @menu.load(@st.current.name.substr(10).split(".")[1])

  _on_role_changed: ->
    @menu.reload()

  menu_click: (item)->
    @menu.click(item)
    state = "dashboard.#{@menu.role()}.#{item.link}"
    @st.transitionTo(state)

