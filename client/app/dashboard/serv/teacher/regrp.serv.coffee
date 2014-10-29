"use strict"
angular.module "brasFeApp"
.service "teacherRegrp", ($rootScope, sessionServ, notify, datagen)->
  nv = datagen.nvp

  _time_sec = [
    nv("上午(0730~1230)", 0),
    nv("下午(1300~1800)", 1),
    nv("晚上(1800~2200)", 2),
  ]

  _actions = [
    nv("新增", 0),
    nv("查詢", 1),
    nv("更新", 2),
  ]

  _new_reg = ->
    contest_id: -1
    exdate: "2014/11/10"
    extime: "" #_time_sec[0].value

  r =
    data:
      inited: false
      regform: _new_reg()
      qryform: {}
      action: _actions[0].value
      list: []
      option:
        time_txt: []
        exdate: datagen.date_opt()
        actions: _actions
        times: _time_sec

  r._time_txt = ->
    r.data.option.time_txt = _.pluck(_time_sec, (t) -> t.name )

  r.init = ->
    return if r.data.inited
    r.data.inited = true
    r._time_txt()
    r.load_conregs()

  r.load_conregs = ->
    rt = sessionServ.fest().all("teacher/conregs")
    rt.get("").then (rp)->
      r.data.list = rp

  r._create = ->
    data = {conreg: r.data.regform}
    rt = sessionServ.fest().all("teacher/conregs")
    rt.post(data).then (rp)->
      r.load_conregs()
      notify.g rp.msg

  r._search = ->
    ""

  r.submit = ->
    if r.data.action == 0
      r._create()
    else
      r._search()

  r.notify = (msg)->
    notify.g msg

  r.contest_list = (q)->
    q = if q is "$empty$" then "" else q
    rst = sessionServ.fest().all("teacher/contests/list")
    rst.get("", {q: q, gcode: r.data.regform.gcode})

  r._map_reg = (reg)->
    contest_id: reg.contest.id
    gcode: reg.ugroup.gcode
    exdate: reg.exdate
    extime: reg.extime

  r.update = (reg)->
    r.data.action = _actions[2].value
    r.data.regform = r._map_reg(reg)

  r
