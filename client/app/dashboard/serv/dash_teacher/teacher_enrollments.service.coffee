"use strict"

angular.module "brasFeApp"
.service "studentEnrollments", (sessionServ, growl)->
  notify = (msg)->
    notifier = growl[msg.status]
    notifier(msg.body, title: msg.title, ttl: 3000)

  ret =
    data:
      gid: null
      init: false
