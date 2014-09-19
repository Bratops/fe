"use strict"
angular.module("brasFeApp").classy.controller
  name: "manager.tasks.NewCtrl"
  inject:
    $scope: "$"
    managerTask: "mt"
    managerNewTask: "nt"

  init: ()->
    @$.data = @nt.data

  btn_clicked: (btn)->
    @nt.data.clicked = btn

  clicked_btn: (btn)->
    if @nt.data.clicked is btn then "active" else ""

  clicked: (form)->
    @nt.data.clicked.value is form

  unset_level: (lvl)->
    lvl.value = 0

  hovering_level: (lvl)->
    #console.log lvl

  level_text: (lvl)->
    a = ["無", "易", "中", "難"]
    a[lvl.value]
