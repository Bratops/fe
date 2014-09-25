"use strict"
angular.module("brasFeApp").classy.controller
  name: "manager.contests.NewCtrl"
  inject:
    $scope: "$"
    managerContest: "mc"

  init: ->
    @$.data = @mc.data

  sdate_cal_disable: (d, m)->
    dv = d.getDay()
    ((m is "day") and ( dv is 0 || dv is 6 ))

  open_cal: (e, name)->
    e.preventDefault()
    e.stopPropagation()
    ov = @$.data.opt[name].open
    @$.data.opt[name].open = !ov
