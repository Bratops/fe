"use strict"

angular.module "brasFeApp"
.service "menu", ($log, sessionServ, growl)->
  notify = (resp)->
    dc = growl[resp.status]
    msg = resp.msg
    dc msg.body, title: msg.title

  ret =
    init: false
    reload: ()->
      ret.init = false
      ret.load()
    load: ()->
      return if ret.init
      ret.init = true
      ret.load_menu()
    data:
      clicked: {}
      menu: {} # load_menu
      raw: {} # get_menu_list
    role: ()->
      sessionServ.user.role.name
    load_menu: ()->
      rest = sessionServ.rest
      rest.all("dashboard/menu?t=#{_.now()}").get("").then (resp)->
        #console.log _.pluck(resp.menu, "name")
        ret.data.menu = resp.menu
    get_menu_list: (role)->
      rest = sessionServ.fest()
      rest.all("dashboard/menu?edit=#{role}").get("").then (resp)->
        ret.data.raw = resp.menu
    update_raw: (role)->
      data =
        role: role
        menu: ret.data.raw
      rest = sessionServ.fest()
      urole = sessionServ.user.role.name
      rest.all("#{urole}").one("menu").post("", data).then (resp)->
        ret.get_menu_list(role)
        notify resp
        #ret.data.raw = resp.menu

