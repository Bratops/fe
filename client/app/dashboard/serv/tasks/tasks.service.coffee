"use strict"
angular.module "brasFeApp"
.service "managerTask", (sessionServ, notify)->
  r =
    inited: false
    data:
      tasks: []

  r.load_tasks = ->
    rest = sessionServ.fest().all("manager/tasks")
    rest.getList().then (resp)->
      r.data.tasks = resp

  r.init = ()->
    return if r.inited
    r.inited = true
    r.load_tasks()

  r
