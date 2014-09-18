"use strict"
angular.module("brasFeApp").classy.controller
  name: "teacher.baseCtrl"
  inject:
    $scope: "$"
    $state: "st"
    sessionServ: "se"

  init: ->
    @$.$on "$stateChangeStart", @_sc_start
    @$.$on "$stateChangeSuccess", @_sc_succ

  _sc_start: (event, toState, toParams, fromState, fromParams)->
    #@se.auth_state(event, toState)

  _sc_succ: (event, toState, toParams, fromState, fromParams)->
    if @st.is("dashboard.teacher")
      @st.go("dashboard.teacher.groups")
    #return unless @se.is_valid_state(@st)
