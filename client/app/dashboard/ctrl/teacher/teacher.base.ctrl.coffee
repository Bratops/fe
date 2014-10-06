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
    dbu = "dashboard.teacher"
    @st.go("#{dbu}.groups") if @st.is(dbu)
    #return unless @se.is_valid_state(@st)
