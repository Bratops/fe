"use strict"
angular.module("brasFeApp").classy.controller
  name: "manager.RegsCtrl"
  inject:
    $scope: "$"
    $state: "st"
    managerRegs: "m"

  init: ->
    @$.data = @ms.data

