"use strict"
angular.module("brasFeApp").classy.controller
  name: "manager.contests.EditCtrl"
  inject:
    $scope: "$"
    $state: "st"
    $stateParams: "stp"
    managerContest: "mc"

  init: ->
    @mc.load(@stp.id)
    @$.data = @mc.data
    @$.inited = false

  watch:
    "data.grading": (nv, ov)->
      return if nv is ov
      @mc.update_grading(nv, @$.inited)
      @$.inited = true

  save: ()->
    @mc.update()
