"use strict"
angular.module("brasFeApp").classy.controller
  name: "manager.ContestsCtrl"
  inject:
    $scope: "$"
    $state: "st"
    managerContest: "mc"
    managerContests: "mcs"

  _on_contest_created: (e, d)->
    @mcs.data.contests.push d
    @st.go("^")

  _on_contest_updated: (e, d)->
    id = _.findIndex(@mcs.data.contests, (c)-> c.id is d.id)
    @mcs.data.contests[id] = d
    @st.go("^")

  init: ->
    @$.data = @mcs.data
    @$.$on "contest:created", @_on_contest_created
    @$.$on "contest:updated", @_on_contest_updated
    @mcs.load()

  remove: (cn)->
    if(confirm("確定移除？"))
      @mcs.remove(cn)

  edit: (cn)->
    if @st.includes("**.contests.new") or @st.includes("**.contests.edit")
      @st.go("^.edit", {id: cn.id})
    else
      @st.go(".edit", {id: cn.id})

  open_cal: (e, name)->
    e.preventDefault()
    e.stopPropagation()
    ov = @mc.data.opt[name].open
    @mc.data.opt[name].open = !ov

  ctask_info: ()->
    a = {}
    _.each @mc.data.ctasks, (t)->
      pv = a["r_#{t.rating}"]
      a["r_#{t.rating}"] = if pv? then pv + 1 else 1
    "易: #{a.r_1 || 0}, 中: #{a.r_2 || 0}, 難: #{a.r_3 || 0}"

  remove_ctask: (tsk)->
    @mc.data.ctasks = _.reject(@mc.data.ctasks, (t)-> t.id is tsk.id)
    @mc.data.tasks.push tsk

  rats: (rating)->
    aa = [ "無", "易", "中", "難"]
    aa[rating]

  add_ctask: (tsk)->
    @mc.data.tasks = _.reject(@mc.data.tasks, (t)-> t.id is tsk.id)
    @mc.data.ctasks.push tsk

  cancel: ()->
    @st.go("^")

  _cal_disable: (d, m)->
    dv = d.getDay()
    ((m is "day") and ( dv is 0 || dv is 6 ))

  sdate_cal_disable: (d, m)->
    @_cal_disable(d, m)

  edate_cal_disable: (d, m)->
    @_cal_disable(d, m)

  get_survey_list: (query)->
    @mc.survey_list(query).then (rsp)->
      rsp

  set_survey: (item, model, label)->
    @mc.data.contest.survey_id = item.id

