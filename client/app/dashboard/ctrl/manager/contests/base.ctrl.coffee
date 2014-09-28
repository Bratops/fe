"use strict"
angular.module("brasFeApp").classy.controller
  name: "manager.ContestsCtrl"
  inject:
    $scope: "$"
    $state: "st"
    managerContests: "mc"

  _on_contest_created: (e, d)->
    @mc.data.contests.push d

  init: ->
    @$.data = @mc.data
    @$.$on "contest:created", @_on_contest_created
    @mc.load()
