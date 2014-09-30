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

  _contest = ->
    name: ""
    sdate: "2014-11-10"
    edate: "2014-11-21"
    grading: 4
    task_ids: []

  r =
    data:
      gradings: _gradings
      grading: _gradings[4]
      tasks: []
      ctasks: []
      query: {}
      opt:
        sdate: datagen.date_opt()
        edate: datagen.date_opt()
      contest: _contest()

  r.reset = ()->
    r.data.contest = _contest()
    r.update_grading(r.data.grading)

  r.update_grading = (g, is_new=true)->
    rst = sessionServ.fest().all("manager/tasks")
    rst.all("list").get("", {rating: g.name}).then (rsp)->
      r.data.ctasks = [] if is_new
      unless is_new
        r.data.tasks = _.reject(rsp, (t)->
          fi = _.findIndex(r.data.ctasks, (ct)-> ct.id is t.id )
          fi >= 0
        )
      else
        r.data.tasks = rsp

  r.contest_obj = ()->
    data = _.clone r.data.contest
    data.grading = r.data.grading.value
    data.task_ids = _.pluck(r.data.ctasks, (t)-> t.id)
    data

  r.create = ()->
    data = r.contest_obj()
    rst = sessionServ.fest().one("manager/contests")
    rst.post("", {contest: data}).then (rsp)->
      notify.g rsp.msg
      if rsp.msg.status is "success"
        $rootScope.$broadcast "contest:created", rsp.data

  r.load = (id)->
    data = r.contest_obj()
    rst = sessionServ.fest().one("manager/contests", id)
    rst.get("").then (rsp)->
      if rsp.status is "success"
        r.data.contest = rsp.data
        r.data.ctasks = rsp.data.tasks
        r.update_grading({name: rsp.data.grading_str}, false)

  r.update = ()->
    data = r.contest_obj()
    rst = sessionServ.fest().one("manager/contests", data.id)
    rst.patch({contest: data}).then (rsp)->
      notify.g rsp.msg
      if rsp.msg.status is "success"
        $rootScope.$broadcast "contest:updated", rsp.data

  r
