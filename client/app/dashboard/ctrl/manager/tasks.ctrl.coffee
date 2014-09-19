"use strict"
angular.module("brasFeApp").classy.controller
  name: "manager.TasksCtrl"
  inject:
    $scope: "$"
    managerTask: "mt"

  init: ->
    @$.data = @mt.data
    @mt.init()
