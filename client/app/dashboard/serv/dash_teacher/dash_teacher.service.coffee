'use strict'

angular.module 'brasFeApp'
.service 'dashTeacher', (sessionServ, growl)->
  klasses = [
      name: "普通班未分組"
      value: 1
    ,
      name: "自然組"
      value: 2
    ,
      name: "社會組"
      value: 3
    ,
      name: "人文社會資優班"
      value: 4
    ,
      name: "數理資優班"
      value: 5
    ,
      name: "資訊相關科別"
      value: 6
    ,
      name: "其他技職科別"
      value: 7
    ,
      name: "其他(請註記)"
      value: 0
  ]

  time_sec = [
      name: "上午(0730~1230)"
      value: 0
    ,
      name: "下午(1300~1800)"
      value: 1
    ,
      name: "晚上(1800~2200)"
      value: 2
  ]

  notify = (msg)->
    notifier = growl[msg.status]
    notifier(msg.body, title: msg.title, ttl: 3000)

  _new_group = ()->
    klass: ""
    exdate: "2014/11/10"
    extime: time_sec[0]
    grade: 10
    note: ""
    name: ""

  _group_data = (data)->
    cd = _.clone(data, true)
    cd.klass = data.klass.value
    cd.extime = data.extime.value
    cd

  ret =
    notify_proc: ()->
      notify
        status: "info"
        title: "處理中"
        body: "請稍後"
    add_group: ()->
      ret.notify_proc()
      rest = sessionServ.rest
      data = _group_data(ret.data.groups.form_group)
      rest.one("teacher").post("ugroups", {grp: data}).then (resp)->
        notify resp.msg
        if resp.msg.status is "success"
          ret.data.groups.list.push resp.data
      ret.data.groups.form_group = _new_group()
    update_group: ()->
      ret.notify_proc()
      rest = sessionServ.rest
      data = _group_data(ret.data.groups.form_group)
      rest.one("teacher/ugroups", data.id).patch({grp: data}).then (resp)->
        notify resp.msg
        if resp.msg.status is "success"
          gi = _.findIndex(ret.data.groups.list, (item)->
            item.id == data.id
          )
          ret.data.groups.list[gi] = resp.data
      ret.data.groups.form_group = _new_group()
    del_group: (g)->
      ret.notify_proc()
      rest = sessionServ.rest
      rest.one("teacher/ugroups", g.id).remove().then (resp)->
        notify resp.msg
        if resp.msg.status is "success"
          ret.data.groups.list = _.reject(ret.data.groups.list, {id: g.id})
    load_groups: (re=false)->
      rest = sessionServ.rest.all("teacher/ugroups")
      opt = _.merge({pg: 1}, if re then {t: _.now()} else {})
      rest.getList(opt).then (resp)->
        ret.data.groups.list = resp
    edit_group: (gp)->
      fg = _.clone(gp, true)
      fg.klass = ret.find_local(gp.klass, "klasses")
      fg.extime = ret.find_local(gp.extime, "time_sec")
      ret.data.groups.form_group = fg
    find_local: (k, key)->
      dg = ret.data.groups[key]
      dv = _.findIndex(dg, (item)->
        item.value == k
      )
      dg[dv]
    load: ()->
      return if ret.data.init
      ret.data.init = true
      ret.load_groups()
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
        klasses: klasses
        time_sec: time_sec
