"use strict"
angular.module "brasFeApp"
.service "userContests", ($rootScope, sessionServ, menu, notify)->
  r =
    inited: false
    data:
      contests: []
      contest: {}

  r.init = ()->
    return if r.inited
    r.inited = true
    r.load_all()

  r.load_all = ->
    rst = sessionServ.fest().all("user/contests")
    rst.get("").then (rsp)->
      r.data.contests = rsp

  r.load_one = ->
    rst = sessionServ.fest().all("user/contests/current")
    rst.get("").then (rsp)->
      r.data.contest = rsp
      if rsp.msg.status is "success"
        r.set_title()
      else
        $rootScope.$broadcast "contest:not_found", ''
    , (err)->
      $rootScope.$broadcast "contest:not_found", ''

  r.set_title = ->
    menu.data.title =
      name: r.data.contest.name
      desc: ""

  r
