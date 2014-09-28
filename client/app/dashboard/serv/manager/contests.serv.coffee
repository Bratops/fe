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
    rst = sessionServ.fest().one("manager/contests")
    rst.get("").then (rsp)->
      r.data.contests = rsp
  r
