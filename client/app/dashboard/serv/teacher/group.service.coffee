"use strict"
angular.module "brasFeApp"
.service "teacherGroup", (sessionServ, notify)->
  nv = (n, v)->
    { name: n, value: v }
  clusters = [
    nv("普通班未分組", 1),
    nv("自然組", 2),
    nv("社會組", 3),
    nv("人文社會資優班", 4),
    nv("數理資優班", 5),
    nv("資訊相關科別", 6),
    nv("其他技職科別", 7),
    nv("其他(請註記)", 0),
  ]

  time_sec = [
    nv("上午(0730~1230)", 0),
    nv("下午(1300~1800)", 1),
    nv("晚上(1800~2200)", 2),
  ]

  _new_group = ()->
    cluster: ""
    exdate: "2014/11/10"
    extime: time_sec[0]
    grade: 10
    note: ""
    name: ""

  _group_data = (data)->
    cd = _.clone(data, true)
    cd.cluster_id = data.cluster.value
    cd.extime = data.extime.value
    cd

  r =
    data:
      init: false
      groups:
        new: false
        new_submitted: false
        edit: false
        edit_submitted: false
        pager:
          page: 1
        list: []
        form_group: _new_group()
        exdate_opt:
          minDate: "'2014/11/10'"  #new Date()
          maxDate: "'2014/11/21'"
          open: false
          startingDay: 1
        clusters: clusters
        time_sec: time_sec

  r.notify_proc = ->
    notify.g
      status: "info"
      title: "處理中"
      body: "請稍後"

  r.add_group = ->
    r.notify_proc()
    rest = sessionServ.rest
    data = _group_data(r.data.groups.form_group)
    rest.one("teacher").post("ugroups", {grp: data}).then (resp)->
      notify.g resp.msg
      if resp.msg.status is "success"
        r.data.groups.list.push resp.data
    r.data.groups.form_group = _new_group()

  r.update_group = ->
    r.notify_proc()
    rest = sessionServ.rest
    data = _group_data(r.data.groups.form_group)
    rest.one("teacher/ugroups", data.id).patch({grp: data}).then (resp)->
      notify.g resp.msg
      if resp.msg.status is "success"
        gi = _.findIndex(r.data.groups.list, (item)->
          item.id == data.id
        )
        r.data.groups.list[gi] = resp.data
    r.data.groups.form_group = _new_group()

  r.del_group = (g)->
    r.notify_proc()
    rest = sessionServ.rest
    rest.one("teacher/ugroups", g.id).remove().then (resp)->
      notify.g resp.msg
      if resp.msg.status is "success"
        r.data.groups.list = _.reject(r.data.groups.list, {id: g.id})

  r.load_groups = (rest)->
    rest = sessionServ.fest().all("teacher/ugroups")
    rest.getList({pg: 1}).then (resp)->
      r.data.groups.list = resp

  r.edit_group = (gp)->
    fg = _.clone(gp, true)
    fg.cluster = r.find_local(gp.cluster_id, "clusters")
    fg.extime = r.find_local(gp.extime, "time_sec")
    r.data.groups.form_group = fg

  r.find_local = (k, key)->
    dg = r.data.groups[key]
    dv = _.findIndex(dg, (item)->
      item.value == k
    )
    dg[dv]

  r.load = ->
    return if r.data.init
    r.data.init = true
    r.load_groups()

  r
