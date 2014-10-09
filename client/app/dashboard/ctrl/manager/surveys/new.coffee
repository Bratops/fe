"use strict"
angular.module("brasFeApp").classy.controller
  name: "manager.surveys.NewCtrl"
  inject:
    $scope: "$"
    $state: "st"
    managerSurveys: "ms"

  init: ->
    @$.data = @ms.data

  submit: ->
    @ms.create()

