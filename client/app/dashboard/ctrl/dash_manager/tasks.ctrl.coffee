"use strict"
app = angular.module("brasFeApp")
class ManagerTasksCtrl extends AppBase
  @register app, "controller", "manager.TasksCtrl"
  @inject "$scope", "managerTask as mt"

  initialize: ->
    @reset()

  reset: ->
    console.log "init task ctrl"

