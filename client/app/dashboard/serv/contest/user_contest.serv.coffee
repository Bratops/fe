"use strict"
angular.module "brasFeApp"
.service "userContests", ($rootScope, sessionServ, menu, notify)->
  _curtask = ->
    seed: []

  _data = ->
    tid: 0
    cur_task: _curtask()
    contests: []
    contest_raw: {}
    contest: {}
    sublist: []

  r =
    inited: false
    data: _data()

  r.testing = ->
    r.data.contest_raw.name?

  r.reset = ->
    r.data = _data()

  r.init = ->
    return if r.inited
    r.inited = true
    r.load_one()

  r.load_all = ->
    rst = sessionServ.fest().all("user/contests")
    rst.get("").then (rsp)->
      notify.g rsp.msg if rsp.msg.status is "warning"
      r.data.contests = rsp.data

  r._reject_done = (dtids)->
    return if dtids.length is 0
    tids = _.pluck(r.data.contest_raw.tasks, (t)-> t.id)
    same = _.intersection(tids, dtids)
    _.each same, (s)->
      r.data.contest_raw.tasks = _.reject(r.data.contest_raw.tasks, (t)->
        t.id == s
      )

  r.setup_contest = (rsp)->
    return r.load_all() if rsp.status is "free"
    if rsp.status is "testing"
      r.data.contest_raw = rsp.contest
      r._reject_done rsp.done_ans
      $rootScope.$broadcast "contest:ready", ''
      r.setup()
    else
      $rootScope.$broadcast "contest:not_found", ''

  r.load_one = ->
    rst = sessionServ.fest().all("user/contests/current")
    rst.post({id: r.data.contest.id}).then r.setup_contest
    , (err)->
      $rootScope.$broadcast "contest:not_found", ''

  r.setup = ->
    menu.data.hide = true
    r._set_title()
    r._switch_to(0)

  r._set_title = ->
    menu.data.title =
      name: r.data.contest_raw.name
      desc: ""

  r.rating_text = ()->
    a = ["", "很簡單", "簡單", "普通", "稍難", "困難"]
    rdc = r.data.cur_task
    if rdc?
      v = if rdc.hrating? then rdc.hrating else 0 #rdc.rating
      a[v]

  r._copy_task = (task, skip_ans)->
    task_id: task.id
    skip: task.skip
    timespan: task.timespan
    kind: task.kind
    ans: r._ansable(task.select, skip_ans)
    rating: task.rating

  r._ansable = (ans, skip_ans)->
    rk = r.data.cur_task.kind
    return "" if skip_ans
    return ans.id if rk is "single"
    return ans.content if rk is "fill"

  r._refresh_tasks = ()->
    return r._switch_to(+1) if r._is_tsk "next"
    rc = r.data.contest_raw
    if rc.tasks.length > 1
      rc.tasks = _.reject(rc.tasks, (t)-> t.id is r.data.cur_task.id)
      r._switch_to(0)
    else
      $rootScope.$broadcast "contest:finished"
      menu.data.hide = false

  r._switch_to = (rinx)->
    tl = r.data.contest_raw.tasks.length
    r.data.tid = (r.data.tid + rinx) % tl
    r.data.cur_task = r.data.contest_raw.tasks[r.data.tid]
    unless r.data.cur_task.seed?
      r.data.cur_task.seed = _.shuffle([0,1,2,3])

  r._is_tsk = (state)->
    r.data.cur_task.submit is state

  r._send = (data)->
    rst = sessionServ.fest().all("user/contests")
    rst.one("current", "submit").post("", {ans: data}).then (rsp)->
      if rsp.status is "error"
        r._send(data)

  r._submit = ()->
    skip = r._is_tsk("drop")
    data = r._copy_task(r.data.cur_task, skip)
    r._send(data)
    #r.data.sublist.push data

  r.next = (next=1)->
    r.data.cur_task.skip += 1 if r._is_tsk("next")
    r._submit() if r._is_tsk("drop") or r._is_tsk("submit")
    r._refresh_tasks()

  r
