"use strict"
angular.module("brasFeApp").classy.controller
  name: "manager.tasks.EditCtrl"
  inject:
    $scope: "$"
    $state: "st"
    $stateParams: "stp"
    managerTask: "nt"

  _on_task_updated: (e, d)->
    @st.go("^")

  _on_state_changed: (event, toState, toParams, fromState, fromParams)->
    #@nt.load_by_id(@stp.id)

  init: ()->
    @nt.edit()
    @$.data = @nt.data
    @$.$on "task:updated", @_on_task_updated
    @$.$on "$stateChangeSuccess", @_on_state_changed

  tab_click: (tab)->
    @nt.data.clicked = tab

  is_tab_clicked: (tab)->
    if @nt.data.clicked is tab then "active" else ""

  clicked: (form)->
    @nt.data.clicked.value is form

  unset_rating: (rat)->
    rat.value = 0

  hovering_rating: (rat)->
    #console.log lvl

  rating_text: (rat)->
    a = ["無", "易", "中", "難"]
    a[rat.value]

  mark_answer: (cho)->
    cho.answer = !cho.answer

  save_task: ()->
    @nt.update()

  cancel: ()->
    @st.go("^")

  json_size: ()->
    @nt.json_size(@nt.data.task)
