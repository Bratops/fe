"use strict"
angular.module("brasFeApp").classy.controller
  name: "teacher.RegrpsCtrl"

  inject:
    $scope: "$"
    $timeout: "timer"
    $rootScope: "rt"
    $state: "st"
    teacherRegrp: "m"

  init: ->
    @$.data = @m.data
    @m.init()

  watch:
    "data.regform.gcode": (nv, ov)->
      if (@$.data.regform.contest_id > 0)
        @$.data.regform.contest_id = -1
        @$.data.contest = ""
    "{object}data.contest": (nv, ov)->
      @$.data.regform.contest_id = -1 if (typeof nv is "string")

  open_calendar: (e)->
    e.preventDefault()
    e.stopPropagation()
    @$.data.option.exdate.open = !@$.data.option.exdate.open

  exdate_cal_disable: (date, mode)->
    dv = date.getDay()
    ((mode is "day") and ( dv is 0 || dv is 6 ))

  submit: -> @m.submit()

  get_contest_list: (q, use_code=true)->
    @m.contest_list(q, use_code).then (r)=>
      @m.notify(r.msg) if r.msg.status is "error"
      r.data

  focus_contest: (e)-> @timer -> $(e.target).trigger('input')

  set_contest: (item, model, label)->
    @m.data.regform.contest_id = item.id
    @$.data.option.exdate.minDate = "'#{item.sdate}'"
    @$.data.option.exdate.maxDate = "'#{item.edate}'"

  set_qry_contest: (i, m, l)->
    @m.data.qryform.contest_id = i.id

  gcode_valid: ->
    !(@$.data.regform.gcode? && @$.data.regform.gcode.length == 6)

  field_invalid: (field)->
    field.$invalid && field.$dirty

  invalid_contest: (field)->
    (@m.data.regform.contest_id < 0) && !field.$pristine

  time_map: (v)->
    @m.data.option.time_txt[v]

  click_reg: (reg)->
    if @m.data.action != 2
      @m.update(reg)
    else
      @m.set_query(reg.ugroup.gcode)
