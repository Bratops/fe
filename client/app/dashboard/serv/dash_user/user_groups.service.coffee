"use strict"

angular.module "brasFeApp"
.service "userGroup", ($rootScope, sessionServ, notify)->
  _new_join = ()->
    moeid: ""
    suid: ""
    gcode: ""

  ret =
    init: false
    data:
      groups: []
      join:
        form: _new_join()
        show: true
    sclist: (query)->
      sessionServ.sclist(query)
    new_join: ->
      ret.data.join.form = _new_join()
    join: ->
      data = _.clone ret.data.join.form
      rest = sessionServ.fest().one("user/ugroups", "join")
      rest.post("", {grp: data}).then (resp)->
        notify.g resp.msg
        #ret.data.groups.push resp.data
