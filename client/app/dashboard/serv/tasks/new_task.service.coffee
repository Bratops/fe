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

  ret =
    data:
      init: false
      part: {}
      btns: _btns
      clicked: _btns[0]
