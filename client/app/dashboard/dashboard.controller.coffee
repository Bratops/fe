"use strict"
angular.module("brasFeApp").classy.controller
  name: "DashboardCtrl"
  inject:
    $scope: "$"
    $state: "st"
    menu: "menu"
    growl: "gw"
    sessionServ: "se"

  init: ->
    @se.warm_up()
    @$.data =
      menu: @menu.data
      role: {}

    @$.$on "$stateChangeStart", @_on_sc_start
    @$.$on "$stateChangeSuccess", @_on_sc_ok
    @$.$on "redirect", @_on_redirect
    @$.$on "$stateNotFound", @_on_no_state
    @$.$on "role_switched", @_role_switched

  _current_role: (role)->
    roles = @se.user.roles
    ri = _.findIndex(roles, (r)-> r.id == role.id)
    if ri < 0 then roles[0] else roles[ri]

  _on_sc_start: (event, toState, toParams, fromState, fromParams)->
    @se.auth_state(event, toState.name)

  _on_sc_ok: (event, toState, toParams, fromState, fromParams)->
    @se.auth_user(toState.name, @st)
    if @se.is_valid_state(@st)
      user = @se.user
      @$.user = user
      @$.data.role = @_current_role(user.role)

  _on_redirect: (event, data)->
    if data is "dashboard"
      @st.go(data + "." + @se.user.role.name)

  _on_no_state: (event, unfoundState, fromState, fromParams)->
    @gw.error "未實作的功能", title: "Oops"
    event.preventDefault()

  watch:
    "data.role": (nv, ov)->
      if ov.id isnt nv.id
        @se.switch_role(nv.id)

  logout: ()->
    @se.logout()
