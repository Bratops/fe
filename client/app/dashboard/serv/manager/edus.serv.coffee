"use strict"
angular.module "brasFeApp"
.service "managerEdus", (sessionServ, notify, datagen)->

  _types = [
    datagen.nvp("區域", "loc"),
    datagen.nvp("屬性", "holder"),
    datagen.nvp("層級", "level"),
    datagen.nvp("學校", "school"),
    datagen.nvp("群組", "cluster"),
    datagen.nvp("班級", "ugroup"),
  ]

  r =
    inited: false
    data:
      list_types: _types
      type: "school"
      query: ""
      list: []

  r._load_list = ->
    rst = sessionServ.fest().all("manager/edus/list")
    rst.get("", {type: r.data.type, query: r.data.query}).then (rsp)->
      r.data.list = rsp

  r.load = ->
    return if r.inited
    r.inited = true
    #r._load_list()

  r.reload_list = ->
    r._load_list()

  r
