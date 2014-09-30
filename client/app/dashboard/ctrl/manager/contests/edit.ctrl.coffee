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

  watch:
    "data.grading": (nv, ov)->
      return if nv is ov
      @mc.update_grading(nv)

  save: ()->
    @mc.update()
