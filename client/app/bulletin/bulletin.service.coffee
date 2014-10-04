"use strict"
angular.module "brasFeApp"
.service "bulletin", (sessionServ, notify, datagen) ->
  _new_msg = ()->
    start_time: new Date
    end_time: datagen.add_day(new Date(), 1)
    title: ""
    body: ""

  _date_opt = ()->
    minDate: new Date()
    open: false
    startingDay: 1

  ret =
    init: false
    ensure_end: (date)->
      if date > ret.data.msg.end_time
        ret.data.msg.end_time = datagen.add_day(date, 1)
    cancel_edit: ()->
      ret.data.msg = _new_msg()
    add_msg: ()->
      data = _.clone(ret.data.msg)
      rest = sessionServ.rest
      rest.one("manager", "msgs").post("", {msg: data}).then (resp)->
        notify.g resp.msg
        ret.data.msgs.push resp.data
        ret.data.msg = _new_msg()
    update_msg: ()->
      data = _.clone(ret.data.msg)
      rest = sessionServ.rest
      rest.one("manager/msgs", data.id).patch({msg: data}).then (resp)->
        notify.g resp.msg
    del_msg: (msg)->
      rest = sessionServ.rest
      rest.one("manager/msgs", msg.id).remove().then (resp)->
        notify.g resp.msg
        if resp.msg.status is "success"
          ret.data.new = ret.data.edit = false
          ret.data.msgs = _.reject(ret.data.msgs, {id: resp.id})
    load_pub: ()->
      return if ret.init
      ret.init = true
      ret.load_pub_msgs()
    load_pub_msgs: ()->
      rest = sessionServ.fest()
      rest.all("msgs").getList().then (resp)->
        ret.data.msgs = resp
    load: ()->
      return if ret.init
      ret.init = true
      ret.load_msgs()
    load_msgs: ()->
      rest = sessionServ.fest()
      rest.all("manager/msgs").getList().then (resp)->
        ret.data.msgs = resp
    set_msg: (msg)->
      ms = if msg? then msg else _new_msg()
      ret.data.msg = ms
    data:
      msgs: []
      new: true
      edit: false
      msg: _new_msg()
      sdate_opt: _date_opt()
      edate_opt: _date_opt()
