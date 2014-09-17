"use strict"
angular.module("brasFeApp").classy.controller
  name: "teacher.GroupsCtrl"

  inject:
    $scope: "$"
    dashTeacher: "dt"

  init: ()->
    @$.data = @dt.data
    @$.$on "$stateChangeSuccess", @_scs

  _scs: (event, toState, toParams, fromState, fromParams)->
    @dt.load_groups()

# groups
  group_new: ()->
    ddg = @dt.data.groups.new
    @dt.data.groups.new = !ddg

  cant_add_group: (form)->
    (@$.data.groups.new_submitted or form.$invalid)

  cant_update_group: (form)->
    (@$.data.groups.edit_submitted or form.$invalid)

  group_update: (form)->
    @$.data.groups.edit = false
    @dt.update_group()
    form.$setPristine()

  group_add: (form)->
    @$.data.groups.new = false
    @dt.add_group()
    form.$setPristine()

  del_group: (g)->
    if(confirm("確定移除？"))
      @dt.del_group(g)

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
    @dt.load_groups(true)

  klass_str: (k)->
    dg = @dt.find_local(k, "klasses")
    dg.name

  extime_str: (k)->
    dg = @dt.find_local(k, "time_sec")
    dg.name

  edit_group: (g)->
    dgu = @$.data.groups.edit
    @$.data.groups.edit = !dgu
    unless dgu
      @dt.edit_group(g)

