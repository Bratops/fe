"use strict"

angular.module "brasFeApp"
.service "menu", ($log, sessionServ, notify)->
  r =
    inited: false
    data:
      title: {}
      clicked: {}
      menu: {} # load_menu
      raw: {} # get_menu_list
      tube:
        player: null
        visible: false
        vars:
          autoplay: 0

  r.reload = ->
    r.inited = false
    r.load()

  r.load = (state="")->
    return if r.inited
    r.inited = true
    r.load_menu(state)

  r.role = ->
    sessionServ.user.role.name

  r.click = (item)->
    r.data.clicked = item
    r.data.title = item

  r.load_menu = (state)->
    rest = sessionServ.rest
    rest.all("dashboard/menu?t=#{_.now()}").get("").then (rsp)->
      r.data.menu = rsp.menu
      ci = _.findIndex(rsp.menu, (m)-> m.link is state)
      r.click rsp.menu[ci]

  r.get_menu_list = (role)->
    rest = sessionServ.fest()
    rest.all("dashboard/menu?edit=#{role}").get("").then (rsp)->
      r.data.raw = rsp.menu

  r.update_raw = (role)->
    data =
      role: role
      menu: r.data.raw
    rest = sessionServ.fest()
    urole = sessionServ.user.role.name
    rest.all("#{urole}").one("menu").post("", data).then (rsp)->
      r.get_menu_list(role)
      notify.g rsp.msg
      #r.data.raw = rsp.menu

  r
