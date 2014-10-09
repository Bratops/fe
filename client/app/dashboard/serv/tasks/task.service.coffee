"use strict"
angular.module "brasFeApp"
.service "managerTask", ($rootScope, sessionServ, notify, datagen)->
  _tabs = [
    datagen.nvp("基本設定", "basic"),
    datagen.nvp("題文及問題", "body"),
    datagen.nvp("選項", "choices"),
    datagen.nvp("資訊", "info"),
    datagen.nvp("其他", "misc")
  ]

  _default_levels = ->
    [
      datagen.kvp("beaver", 0),
      datagen.kvp("benjamin", 0),
      datagen.kvp("cadet", 0),
      datagen.kvp("senior", 0),
      datagen.kvp("junior", 0)
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

  r.edit = ->
    r.data.clicked = _tabs[0]

  r.new = ->
    r.data.task = _new_task()
    r.data.clicked = _tabs[0]

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
      $rootScope.$broadcast "task:edit:loaded", id

  r
