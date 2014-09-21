"use strict"
angular.module("brasFeApp").classy.controller
  name: "manager.TasksCtrl"
  inject:
    $scope: "$"
    $timeout: "timeout"
    managerTasks: "mt"

  _on_task_created: (e, d)->
    @mt.data.tasks.push d

  _on_state_change: (event, toState, toParams, fromState, fromParams)->
    @_stop_timer()

  _on_timeout: ->
    @mt.data.hoverable = true

  _stop_timer: ->
    @timeout.cancel(@$.timer)
    @mt.data.hoverable = true

  init: ->
    @$.data = @mt.data
    @mt.init()
    @$.$on "$stateChangeStart", @_on_state_change
    @$.$on "task:created", @_on_task_created

  hover_tsk: (tsk)->
    return unless @mt.data.hoverable
    @mt.data.task = tsk
    @mt.data.clicked = false
    @mt.data.hovered = true

  click_tsk: (tsk)->
    @mt.data.task = tsk
    @mt.data.clicked = true
    @mt.data.hovered = false
    @_stop_timer()
    @mt.data.hoverable = false
    @$.timer = @timeout(@_on_timeout, 5000)

  show_hover: ()->
    _.keys(@$.data.task).join(",")

  clicked_tsk: (tsk)->
    if tsk.tid is @mt.data.task.tid
      "clicked"

  range: (v)->
    _.range(0, v)

  watch:
    "data.query": (nv, ov)->
      @mt.reload_tasks()

  show: (typ)->
    @mt.data.show = typ

  remove: (tsk)->
    if(confirm("確定移除？"))
      @mt.remove(tsk)
