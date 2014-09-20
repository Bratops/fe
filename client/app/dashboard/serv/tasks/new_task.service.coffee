"use strict"
angular.module "brasFeApp"
.service "managerNewTask", (sessionServ, notify)->
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
      name: "Beaver"
      value: 0
    ,
      name: "Benjamin"
      value: 0
    ,
      name: "Cadet"
      value: 0
    ,
      name: "Senior"
      value: 0
    ,
      name: "Junior"
      value: 0
    ]

  _choice = (index=0)->
    index: index
    content: ""

  r =
    data:
      init: false
      task:
        levels: _default_levels()
        choices: _.map([0,1,2,3], (v)-> _choice(v))
        keywords: []
        klass: []
        opens: []
      tabs: _tabs
      clicked: _tabs[0]
  r
