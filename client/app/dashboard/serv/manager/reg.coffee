"use strict"
angular.module "brasFeApp"
.service "managerRegs", ($rootScope, sessionServ, notify, datagen)->
  r =
    inited: false
    data:
      list: []

  r.init = ->
    return if r.inited
    r.inited = true

  r

