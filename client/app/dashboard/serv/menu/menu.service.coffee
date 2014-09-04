'use strict'

angular.module 'brasFeApp'
.service 'menu', ($log, sessionServ)->

  ret =
    init: false
    reload: ()->
      ret.init = false
      ret.load()
    load: ()->
      ret.init = true
      ret.load_menu()
    data: {}
    load_menu: ()->
      rest = sessionServ.rest
      rest.all("dashboard/menu").get("").then (resp)->
        #$log.debug resp.menu
        ret.data.menu = resp.menu
