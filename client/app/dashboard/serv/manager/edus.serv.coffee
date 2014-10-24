"use strict"
angular.module "brasFeApp"
.service "managerEdus", ($rootScope, sessionServ, notify, datagen)->

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
      detail: {}
      pager:
        page: 1
        per_page: 20

  r.detail_route = ->
    "dashboard.manager.edus.details"

  r._load_list = ->
    rst = sessionServ.fest().all("manager/edus/list")
    rst.get("", {type: r.data.type, query: r.data.query}).then (rsp)->
      r.data.list = rsp

  r.load_detail = (item)->
    data =
      type: r.data.type
      pager: r.data.pager
    rst = sessionServ.fest().one("manager/edus", item.id)
    rst.all("details").post(data).then (rsp)->
      r.data.detail = rsp
      $rootScope.$broadcast "edus:detail:loaded", item.id

  r.load = ->
    return if r.inited
    r.inited = true
    #r._load_list()

  r.reload_list = ->
    r._load_list()

  r
