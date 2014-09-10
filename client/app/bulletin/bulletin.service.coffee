'use strict'

angular.module 'brasFeApp'
.service 'bulletin', (sessionServ, growl) ->
  notify = (msg)->
    notifier = growl[msg.status]
    notifier(msg.body, title: msg.title, ttl: 3000)

  _add_day = (base_day, day)->
    dt = base_day || new Date()
    dt.setDate(dt.getDate() + day)
    dt

  _new_msg = ()->
    n = new Date()
    start: n
    end: _add_day(n, 5)
    title: "a"
    body: "b"

  _date_opt = ()->
    minDate: new Date()
    open: false
    startingDay: 1

  ret =
    ensure_end: (date)->
      if date > ret.data.msg.end
        ret.data.msg.end = _add_day(date, 1)
    cancel_edit: ()->
      ret.data.msg = _new_msg()
    add_msg: ()->
      data = _.clone(ret.data.msg)
      rest = sessionServ.rest
      rest.one("msg").post(data).then (resp)->
        console.log resp.msg
        ret.data.msgs.push resp.data
    data:
      msgs: []
      new: true
      edit: false
      msg: _new_msg()
      sdate_opt: _date_opt()
      edate_opt: _date_opt()
