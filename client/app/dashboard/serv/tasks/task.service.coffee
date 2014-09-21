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

  r =
    data:
      init: false
      task:
        ratings: _default_levels()
        choices: _.map([0,1,2,3], (v)-> _choice(v))
        keywords: []
        klass: []
        opens: []
      tabs: _tabs
      clicked: _tabs[0]
  r.save = ->
    data = _.clone(r.data.task)
    rst = sessionServ.fest().all("manager/tasks")
    rst.post({task: data}).then (resp)->
      notify.g resp.msg
      $rootScope.$broadcast "task:created", resp.task
  r.json_size = (obj)->
    objs = JSON.stringify(obj)
    m = encodeURIComponent(objs).match(/%[89ABab]/g)
    ml = if m? then m.length else 0
    objs.length + ml
  r
