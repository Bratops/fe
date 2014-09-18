"use strict"
angular.module("brasFeApp").classy.controller
  name: "teacher.PersonalCtrl"
  inject:
    $scope: "$"
    sessionServ: "session"
    teacherGroup: "tg"

  init: ->
    console.log @tg.data.groups.list.length
    @$.$on "$stateChangeSuccess", @_scs
    @$.user = @session.user

  _scs: (event, toState, toParams, fromState, fromParams)->
    ""

