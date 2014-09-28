"use strict"
angular.module("brasFeApp").classy.controller
  name: "manager.contests.NewCtrl"
  inject:
    $scope: "$"
    $state: "st"
    managerContest: "mc"

  _cal_disable: (d, m)->
    dv = d.getDay()
    ((m is "day") and ( dv is 0 || dv is 6 ))

  sdate_cal_disable: (d, m)->
    @_cal_disable(d, m)

  edate_cal_disable: (d, m)->
    @_cal_disable(d, m)

  init: ->
    @mc.reset()
    @$.data = @mc.data

  open_cal: (e, name)->
    e.preventDefault()
    e.stopPropagation()
    ov = @$.data.opt[name].open
    @$.data.opt[name].open = !ov

  watch:
    "data.grading": (nv, ov)->
      return if nv is ov
      @mc.update_grading(nv)

  rats: (rating)->
    aa = [ "無", "易", "中", "難"]
    aa[rating]

  add_ctask: (tsk)->
    @mc.data.tasks = _.reject(@mc.data.tasks, (t)-> t.id is tsk.id)
    @mc.data.ctasks.push tsk

  remove_ctask: (tsk)->
    @mc.data.ctasks = _.reject(@mc.data.ctasks, (t)-> t.id is tsk.id)
    @mc.data.tasks.push tsk

  ctask_info: ()->
    a = {}
    _.each @mc.data.ctasks, (t)->
      pv = a["r_#{t.rating}"]
      a["r_#{t.rating}"] = if pv? then pv + 1 else 1
    "易: #{a.r_1 || 0}, 中: #{a.r_2 || 0}, 難: #{a.r_3 || 0}"

  cancel: ()->
    @st.go("^")

  save: ()->
    @mc.create()
