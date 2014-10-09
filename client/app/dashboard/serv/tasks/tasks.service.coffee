"use strict"
angular.module "brasFeApp"
.service "managerTasks", (sessionServ, notify, datagen)->
  _fts = [
    datagen.nvp("全部", "$"),
    datagen.nvp("標題", "title"),
    datagen.nvp("關鍵字", "keywords"),
    datagen.nvp("類別", "klasses"),
    datagen.nvp("ID", "tid"),
  ]

  r =
    inited: false
    data:
      tasks: []
      task: {}
      hovered: false
      hoverable: true
      clicked: false
      year_query: ""
      query: {}
      fts: _fts
      ft: _fts[0]
      show: "info"

  r.load_tasks = ->
    rest = sessionServ.fest().all("manager/tasks")
    rest.getList({query: _.parseInt(r.data.year_query)}).then (resp)->
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
