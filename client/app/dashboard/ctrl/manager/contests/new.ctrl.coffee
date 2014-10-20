"use strict"
angular.module("brasFeApp").classy.controller
  name: "manager.contests.NewCtrl"
  inject:
    $scope: "$"
    $state: "st"
    managerContest: "mc"

  init: ->
    @mc.reset()
    @$.data = @mc.data

  watch:
    "data.survey": (nv, ov)->
      @mc.data.contest.survey_id = null unless nv?
    "data.grading": (nv, ov)->
      return if nv is ov
      @mc.update_grading(nv)

  save: ()->
    @mc.create()
