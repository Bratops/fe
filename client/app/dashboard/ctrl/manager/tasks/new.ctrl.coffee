"use strict"
angular.module("brasFeApp").classy.controller
  name: "manager.tasks.NewCtrl"
  inject:
    $scope: "$"
    $state: "st"
    managerTask: "nt"
    managerTasks: "nts"

  _on_task_created: (e, d)->
    @st.go("^")

  init: ->
    @nt.new()
    @$.data = @nt.data
    @$.$on "task:created", @_on_task_created

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
    @nt.save()

  cancel: ()->
    @st.go("^")

  json_size: ()->
    @nt.json_size(@nt.data.task)

