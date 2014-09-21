"use strict"
angular.module "brasFeApp"
.service "managerTasks", (sessionServ, notify)->
  r =
    inited: false
    data:
      tasks: []
      task: {}
      hovered: false
      hoverable: true
      clicked: false
      query: ""
      show: "info"

  r.load_tasks = ->
    rest = sessionServ.fest().all("manager/tasks")
    rest.getList({query: _.parseInt(r.data.query)}).then (resp)->
      r.data.tasks = resp

  r.init = ()->
    return if r.inited
    r.inited = true
    r.load_tasks()

  r.reload_tasks = ()->
    r.load_tasks()

  r.remove = (tsk)->
    rest = sessionServ.fest().one("manager/tasks", tsk.tid)
    rest.remove().then (resp)->
      notify.g resp.msg
      if resp.msg.status is "success"
        r.data.tasks = _.reject(r.data.tasks, (t)-> t.tid is tsk.tid)
        r.data.task = {}
  r
