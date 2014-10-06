"use strict"
angular.module "brasFeApp"
.service "userScores", (sessionServ, notify)->
  r =
    inited: false
    data:
      scores: []

  r.init = ->
    return if r.inited
    r.inited = true
    r.load()

  r.load = ->
    rst = sessionServ.fest().all("user/scores")
    rst.get("").then (rsp)->
      r.data.scores = rsp

  r
