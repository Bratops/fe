"use strict"
angular.module("brasFeApp").classy.controller
  name: "manager.TasksCtrl"
  inject:
    $scope: "$"
    $state: "st"
    $timeout: "timeout"
    managerTask: "nt"
    managerTasks: "mt"

  _on_task_created: (e, d)->
    @mt.data.tasks.push d

  _on_task_updated: (e, d)->
    ti = _.findIndex(@mt.data.tasks, (t)-> t.tid == d.tid)
    @mt.data.tasks[ti] = d

  _on_state_change: (event, toState, toParams, fromState, fromParams)->
    @_stop_timer()

  _on_timeout: ->
    @mt.data.hoverable = true

  _stop_timer: ->
    @timeout.cancel(@$.timer)
    @mt.data.hoverable = true

  _on_task_loaded: (e, d)->
    @st.go("dashboard.manager.tasks.edit", {id: d})

  init: ->
    @$.data = @mt.data
    @mt.init()
    @$.$on "$stateChangeStart", @_on_state_change
    @$.$on "task:edit:loaded", @_on_task_loaded
    @$.$on "task:created", @_on_task_created
    @$.$on "task:updated", @_on_task_updated

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
    "data.year_query": (nv, ov)->
      @mt.reload_tasks()
    "data.ft": (nv, ov)->
      @mt.data.query = ""

  show: (typ)->
    @mt.data.show = typ

  is_show: (typ)->
    return "_on" if @mt.data.show is typ

  remove: (tsk)->
    if(confirm("確定移除？"))
      @mt.remove(tsk)

  edit: (tsk)->
    @nt.load_by_id(tsk.tid)

  re_index: (inx)->
    ra = ["A", "B", "C", "D"]
    ra[inx]

