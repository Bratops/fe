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
    nv("更新", 1),
    nv("查詢", 2),
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

  r.load_conregs = (q={})->
    rt = sessionServ.fest().all("teacher/conregs")
    rt.get("", q).then (rp)->
      r.data.list = rp

  r._refresh = (msg)->
    r.load_conregs()
    notify.g msg

  r._create = ->
    data = {conreg: r.data.regform}
    rt = sessionServ.fest().all("teacher/conregs")
    rt.post(data).then (rp)-> r._refresh(rp.msg)

  r._update = ->
    data = {conreg: r.data.regform}
    rt = sessionServ.fest().one("teacher/conregs", r.data.regform.id)
    rt.patch(data).then (rp)-> r._refresh(rp.msg)

  r._search = ->
    r.load_conregs(r.data.qryform)

  r.submit = ->
    subs = ["_create", "_update", "_search"]
    r[subs[r.data.action]]()

  r.notify = (msg)->
    notify.g msg

  r._query_contest = (data)->
    rst = sessionServ.fest().all("teacher/contests/list")
    rst.get("", data)

  r.contest_list = (q, use_code)->
    q = if q is "$empty$" then "" else q
    data = {q: q}
    data.gcode = r.data.regform.gcode if use_code
    r._query_contest(data)

  r._map_reg = (reg)->
    id: reg.id
    contest_id: reg.contest.id
    gcode: reg.ugroup.gcode
    exdate: reg.exdate
    extime: reg.extime

  r.update = (reg)->
    r.data.action = _actions[1].value
    r.data.regform = r._map_reg(reg)

  r.set_query = (gcode)->
    r.data.qryform.gcode = gcode

  r.set_gcode = (gcode)->
    r.data.regform.gcode = gcode

  r.remove = (reg)->
    rt = sessionServ.fest().one("teacher/conregs", reg.id)
    rt.remove("").then (rp)->
      console.log rp
      r._refresh(rp.msg)

  r
