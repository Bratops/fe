"use strict"

angular.module "brasFeApp"
.service "notify", (growl) ->
  ret =
    ttl: 3000
    g: (msg)->
      notifier = growl[msg.status]
      notifier(msg.body, title: msg.title, ttl: ret.ttl)
    c: (msg)->
      console.log msg
    gc: (msg)->
      ret.g(msg)
      ret.c(msg)

