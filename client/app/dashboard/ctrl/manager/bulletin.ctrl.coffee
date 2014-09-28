"use strict"
angular.module("brasFeApp").classy.controller
  name: "manager.BulletinCtrl"
  inject:
    $scope: "$"
    bulletin: "bt"

  init: ->
    @$.data = @bt.data
    @$.$on "$stateChangeSuccess", @_on_state_changed

  _on_state_changed: (event, toState, toParams, fromState, fromParams)->
    @bt.load()

  watch:
    "data.msg.start_time": (nv, ov)->
      @bt.ensure_end(nv)

  msg_editor_visible: ()->
    @$.data.new || @$.data.edit

  cancel_editor: ()->
    @$.data.new = false
    @$.data.edit = false
    @bt.cancel_edit()

  new_msg: ()->
    @$.data.new = true
    @$.data.edit = false
    @bt.set_msg()

  del_msg: (msg)->
    if(confirm("確定移除？"))
      @bt.del_msg(msg)

  edit_msg: (msg)->
    @$.data.new = false
    @$.data.edit = true
    @bt.set_msg(msg)

  add_msg: ()->
    @$.data.new = false
    @bt.add_msg()

  update_msg: ()->
    @$.data.edit = false
    @bt.update_msg()

  open_calendar: (e, key)->
    e.preventDefault()
    e.stopPropagation()
    if key is "edate_opt"
      @$.data[key].minDate = @$.data.msg.start_time
    @$.data[key].open = !@$.data[key].open

  msg_start_cal_disable: (date, mode)->
    false

  msg_end_cal_disable: (date, mode)->
    false

