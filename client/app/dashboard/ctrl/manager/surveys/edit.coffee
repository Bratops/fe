"use strict"
angular.module("brasFeApp").classy.controller
  name: "manager.surveys.EditCtrl"
  inject:
    $scope: "$"
    $stateParams: "stp"
    managerSurveys: "ms"

  init: ->
    @$.data = @ms.data
    @ms.edit_reload(@stp.id)

  is_edit: ->
    true

  submit: ->
    @ms.update()

