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
