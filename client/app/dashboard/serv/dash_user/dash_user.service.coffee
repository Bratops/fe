'use strict'

angular.module 'brasFeApp'
.service 'dashUser', ($rootScope, sessionServ)->
  ret =
    users: {}
    user: {}
    init: false
    load: ()->
      return if ret.init
      ret.init = true
      ret.user = sessionServ.user
    load_users: ()->
      rest = sessionServ.rest
      role = sessionServ.user.role
      rest.all("#{role.name}/users").get("").then (resp)->
        ret.users = resp.data
        $rootScope.$broadcast "users_loaded"
