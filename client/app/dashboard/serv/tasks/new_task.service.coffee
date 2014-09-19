"use strict"
angular.module "brasFeApp"
.service "managerNewTask", (sessionServ, notify)->
  _btns = [
    name: "基本設定"
    value: "basic"
  ,
    name: "題文"
    value: "body"
  ,
    name: "問題及選項"
    value: "quest"
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

  r =
    data:
      init: false
      task:
        levels: _default_levels()
      btns: _btns
      clicked: _btns[0]
  r
