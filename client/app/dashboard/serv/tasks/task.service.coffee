"use strict"
angular.module "brasFeApp"
.service "managerTask", ($rootScope, sessionServ, notify)->
  _tabs = [
    name: "基本設定"
    value: "basic"
  ,
    name: "題文及問題"
    value: "body"
  ,
    name: "選項"
    value: "choices"
  ,
    name: "資訊"
    value: "info"
  ,
    name: "其他"
    value: "misc"
  ]

  _default_levels = ->
    [
      key: "beaver"
      value: 0
    ,
      key: "benjamin"
      value: 0
    ,
      key: "cadet"
      value: 0
    ,
      key: "senior"
      value: 0
    ,
      key: "junior"
      value: 0
    ]

  _choice = (index=0)->
    index: index
    content: ""
    answer: false

  _new_task = ()->
    ratings: _default_levels()
    choices: _.map([0,1,2,3], (v)-> _choice(v))
    authors: []
    keywords: []
    klasses: []
    opens: []

  r =
    data:
      init: false
      task: _new_task()
      tabs: _tabs
      clicked: _tabs[0]

  r._serve = (method, evt) ->
    data = _.clone(r.data.task)
    rst = sessionServ.fest()
    rst = if method is "patch" then rst.one("manager/tasks", data.id) else rst.all("manager/tasks")
    rst[method]({task: data}).then (resp)->
      notify.g resp.msg
      if resp.msg.status is "success"
        r.data.task = _new_task()
        $rootScope.$broadcast "task:#{evt}", resp.task

  r.update = ->
    r._serve("patch", "updated")

  r.save = ->
    r._serve("post", "created")

  r.json_size = (obj)->
    objs = JSON.stringify(obj)
    m = encodeURIComponent(objs).match(/%[89ABab]/g)
    ml = if m? then m.length else 0
    objs.length + ml

  r.load_by_id = (id)->
    rst = sessionServ.fest().one("manager/tasks", id)
    rst.get("").then (resp)->
      r.data.task = resp
  r
