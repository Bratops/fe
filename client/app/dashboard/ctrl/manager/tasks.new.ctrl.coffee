"use strict"
angular.module("brasFeApp").classy.controller
  name: "manager.tasks.NewCtrl"
  inject:
    $scope: "$"
    managerTask: "mt"
    managerNewTask: "nt"

  init: ()->
    @$.data = @nt.data

  tab_click: (tab)->
    @nt.data.clicked = tab

  is_tab_clicked: (tab)->
    if @nt.data.clicked is tab then "active" else ""

  clicked: (form)->
    @nt.data.clicked.value is form

  unset_level: (lvl)->
    lvl.value = 0

  hovering_level: (lvl)->
    #console.log @$.data.task
    #console.log lvl

  level_text: (lvl)->
    a = ["無", "易", "中", "難"]
    a[lvl.value]
