"use strict"
angular.module "brasFeApp"
.service "managerContest", ($rootScope, sessionServ, notify, datagen)->
  _gradings = [
    datagen.nvp("Beaver", 0),
    datagen.nvp("Benjemin", 1),
    datagen.nvp("Cadet", 2),
    datagen.nvp("Junior", 3),
    datagen.nvp("Senior", 4),
  ]

  _data = ->
    gradings: _gradings
    grading: _gradings[4]
    tasks: []
    ctasks: []
    query: {}
    opt:
      sdate: datagen.date_opt()
      edate: datagen.date_opt()
    contest:
      name: ""
      sdate: "2014-11-10"
      edate: "2014-11-21"
      grading: 4
      task_ids: []

  r = { data: _data() }

  r.reset = ()->
    r.data = _data()
    r.update_grading(r.data.grading)

  r.update_grading = (g)->
    rst = sessionServ.fest().all("manager/tasks")
    rst.all("list").get("", {rating: g.name}).then (rsp)->
      r.data.tasks = rsp

  r.contest_obj = ()->
    data = _.clone r.data.contest
    data.task_ids = _.pluck(r.data.ctasks, (t)-> t.id)
    data

  r.create = ()->
    data = r.contest_obj()
    console.log data
    rst = sessionServ.fest().one("manager/contests")
    rst.post("", {contest: data}).then (rsp)->
      notify.g rsp.msg
      if rsp.msg.status is "success"
        $rootScope.$broadcast "contest:create", rsp.data

  r
