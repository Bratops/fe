"use strict"
angular.module("brasFeApp").classy.controller
  name: "teacher.GroupsCtrl"

  inject:
    $scope: "$"
    teacherGroup: "tg"

  init: ()->
    @$.data = @tg.data
    @$.$on "$stateChangeSuccess", @_scs

  _scs: (event, toState, toParams, fromState, fromParams)->
    @tg.load()

# groups
  group_new: ()->
    console.log @tg.data.groups.list.length
    ddg = @tg.data.groups.new
    @tg.data.groups.new = !ddg

  cant_add_group: (form)->
    (@$.data.groups.new_submitted or form.$invalid)

  cant_update_group: (form)->
    (@$.data.groups.edit_submitted or form.$invalid)

  group_update: (form)->
    @$.data.groups.edit = false
    @tg.update_group()
    form.$setPristine()

  group_add: (form)->
    @$.data.groups.new = false
    @tg.add_group()
    form.$setPristine()

  del_group: (g)->
    if(confirm("確定移除？"))
      @tg.del_group(g)

  group_new_cancel: ()->
    @$.data.groups.new_submitted = false
    @$.data.groups.new = false
    @$.data.groups.edit = false

  open_calendar: (e)->
    e.preventDefault()
    e.stopPropagation()
    @$.data.groups.exdate_opt.open = !@$.data.groups.exdate_opt.open

  group_exdate_cal_disable: (date, mode)->
    dv = date.getDay()
    ((mode is "day") and ( dv is 0 || dv is 6 ))

  form_invalid: (field)->
    field.$invalid && !field.$pristine

  reload_groups: ()->
    @tg.load_groups(true)

  klass_str: (k)->
    dg = @tg.find_local(k, "klasses")
    dg.name

  extime_str: (k)->
    dg = @tg.find_local(k, "time_sec")
    dg.name

  edit_group: (g)->
    dgu = @$.data.groups.edit
    @$.data.groups.edit = !dgu
    unless dgu
      @tg.edit_group(g)

