"use strict"
angular.module("brasFeApp").classy.controller
  name: "student.baseCtrl"
  inject:
    $scope: "$"

  init: ->
    @$.$on "$stateChangeSuccess", @_scs

  _scs: (event, toState, toParams, fromState, fromParams)->
    ""
