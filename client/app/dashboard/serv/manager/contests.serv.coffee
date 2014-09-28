"use strict"
angular.module "brasFeApp"
.service "managerContests", (sessionServ, notify, datagen)->

  r =
    inited: false
    data:
      contests: []

  r.load = ()->
    return if r.inited
    r.inited = true
    rst = sessionServ.fest().all("manager/contests")
    rst.get("").then (rsp)->
      r.data.contests = rsp

  r.remove = (cn)->
    rst = sessionServ.fest().one("manager/contests", cn.id)
    rst.remove("").then (rsp)->
      notify.g rsp.msg
      if rsp.msg.status is "success"
        r.data.contests = _.reject(r.data.contests, (c)-> c.id is cn.id)

  r
