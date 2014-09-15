"use strict"

angular.module "brasFeApp"
.service "managerUsers", (sessionServ, notify)->
  ret =
    init: false
    data:
      pager:
        page: 1
        per_page: 30
      users: []
      mod: ""
    load: ()->
      return if ret.init
      ret.init = true
    load_users: (kind)->
      #return if ret.data.mod is kind
      kind = kind || ret.data.mod
      ret.load_users_req(kind)
    load_users_req: (kind)->
      role = sessionServ.user.role.name
      rest = sessionServ.fest().all("#{role}/users")
      rest.one("list", kind).get(ret.data.pager).then (resp)->
        ret.data.users = resp.users
        ret.data.pager.total = resp.total
        ret.data.mod = kind
    mark_teacher: (user)->
      role = sessionServ.user.role.name
      rest = sessionServ.fest().all("#{role}/users")
      rest.one("approve_teacher").post("", {id: user.id}).then (resp)->
        notify.g resp.msg
        if resp.msg.status is "success"
          ret.data.users = _.reject(ret.data.users, (u)->
            u.id == user.id
          )
