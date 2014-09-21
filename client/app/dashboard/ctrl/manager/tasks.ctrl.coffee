"use strict"
angular.module("brasFeApp").classy.controller
  name: "manager.TasksCtrl"
  inject:
    $scope: "$"
    managerTasks: "mt"

  _on_task_created: (e, d)->
    @mt.data.tasks.push d

  init: ->
    @$.data = @mt.data
    @mt.init()
    @$.$on "task:created", @_on_task_created
